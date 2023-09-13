Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22EC79F247
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjIMToJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjIMToI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EA9B
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 12:44:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2921901a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694634242; x=1695239042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymH1v6cOBwI8SJ/5mETElIehW/IG9VVdKuCvlgGH9zI=;
        b=UiXuCXjcyR6hVjFPlwuTS/HRTbrbIkqG98Ij90Tqx2DZpyUtb0CRXcUulpgAobbXE+
         U8xBPEOAjB/D0IMty0hWfRRZefAvCItykPE1PPuH58sWDUlYfJAInh5JR9jtdzrAQMUQ
         5cSdeYNvHWQWy7TQmlasilYmQuwdbNn8RwkMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694634242; x=1695239042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymH1v6cOBwI8SJ/5mETElIehW/IG9VVdKuCvlgGH9zI=;
        b=j7DaqsFEr4EKTJahxHpEaLaTTk2DDqq1THgV3QXj20xr1jeuPA/Zfnrvjsu96B4K2g
         6bACsVHF5s5DS+m4aBT0vHdMc7+LJtHX1cAY+MbCs8j50M/TOUTNA1JGS0Fv/VYrloFL
         F3tlN6JI94uQxhiiaEqw5QR0kxhwDTTqOV0LoAKVg0rB3WckUBBBOsWHpwpEimVjJfeL
         EJvT8Nvhs3F+eVDOFvnegL4XZ69pFJLTlVCUu6ZGFAW18N/dMgC19wBH1o6FsikL9Jic
         MNeUYVIhV0u27dhjzWyCY+WHGTEtuUG47plmP5u6AerY0hHf7bGekqwaDXI0JLszarCw
         ETcA==
X-Gm-Message-State: AOJu0YziQqQLUCtHaBZa8Rx/BN/BcQX2427Lv8zZOBFhasDwOLmp3ST+
        DIW0vswtby6qYEDz43J+B91Smf2h3ZWo8BByo0drlqHV
X-Google-Smtp-Source: AGHT+IHB5hF2dSiF5eb11MMn7D9JvTXtO40gFkkKRwVpMc6D2Npp2SXvOe8F/c2aAtha0yJEVVvChg==
X-Received: by 2002:a05:6402:35c1:b0:52b:db44:79e3 with SMTP id z1-20020a05640235c100b0052bdb4479e3mr10066903edc.4.1694634242058;
        Wed, 13 Sep 2023 12:44:02 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id fi23-20020a056402551700b0052f66414ec6sm4476486edb.56.2023.09.13.12.44.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:44:01 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso292905766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 12:44:01 -0700 (PDT)
X-Received: by 2002:a17:907:6e92:b0:9ad:7840:ab29 with SMTP id
 sh18-20020a1709076e9200b009ad7840ab29mr11942207ejc.32.1694634240890; Wed, 13
 Sep 2023 12:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230913165648.2570623-1-dhowells@redhat.com> <20230913165648.2570623-8-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-8-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 12:43:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiULvMMcdf36JU3daqnTG2KqtJwm788k6fR4bJo7LvAiw@mail.gmail.com>
Message-ID: <CAHk-=wiULvMMcdf36JU3daqnTG2KqtJwm788k6fR4bJo7LvAiw@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iov_iter: Make copy_from_iter() always handle MCE
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Sept 2023 at 09:57, David Howells <dhowells@redhat.com> wrote:
>
> Make copy_from_iter() always catch an MCE and return a short copy and make
> the coredump code rely on that.  This requires arch support in the form of
> a memcpy_mc() function that returns the length copied.

What?

This patch seems to miss the point of the machine check copy entirely.

You create that completely random memcpy_mc() function, that has
nothing to do with our existing copy_mc_to_kernel(), and you claim
that the issue is that it should return the length copied.

Which is not the issue at all.

Several x86 chips will HANG due to internal CPU corruption if you use
the string instructions for copying data when a machine check
exception happens (possibly only due to memory poisoning with some
non-volatile RAM thing).

Are these chips buggy? Yes.

Is the Intel machine check architecture nasty and bad? Yes, Christ yes.

Can these machines hang if user space does repeat string instructions
to said memory? Afaik, very much yes again. They are buggy.

I _think_ this only happens with the non-volatile storage stuff (thus
the dax / pmem / etc angle), and I hope we can put it behind us some
day.

But that doesn't mean that you can take our existing
copy_mc_to_kernel() code that tries to work around this and replace it
with something completely different that definitely does *not* work
around it.

See the comment in arch/x86/lib/copy_mc_64.S:

 * copy_mc_fragile - copy memory with indication if an exception /
fault happened
 *
 * The 'fragile' version is opted into by platform quirks and takes
 * pains to avoid unrecoverable corner cases like 'fast-string'
 * instruction sequences, and consuming poison across a cacheline
 * boundary. The non-fragile version is equivalent to memcpy()
 * regardless of CPU machine-check-recovery capability.

and yes, it's disgusting, and no, I've never seen a machine that does
this, since it's all "enterprise hardware", and I don't want to touch
that shite with a ten-foot pole.

Should I go on another rant about how "enterprise" means "over-priced
garbage, but with a paper trail of how bad it is, so that you can
point fingers at somebody else"?

That's true both when applied to software and to hardware, I'm afraid.

So if we get rid of that horrendous "copy_mc_fragile", then pretty
much THE WHOLE POINT of the stupid MC copy goes away, and we should
just get rid of it all entirely.

Which might be a good idea, but is absolutely *not* something that
should be done randomly as part of some iov_iter rewrite series.

I'll dance on the grave of that *horrible* machine check copy code,
but when I see this as part of iov_iter cleanup, I can only say "No.
Not this way".

> [?] Is it better to kill the thread in the event of an MCE occurring?

Oh, the thread will be dead already. In fact, if I understand the
problem correctly, the whole f$^!ng machine will be dead and need to
be power-cycled.

                 Linus
