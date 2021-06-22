Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29E03B0D36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFVSyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVSyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:54:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814BC061574;
        Tue, 22 Jun 2021 11:51:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i6so307575pfq.1;
        Tue, 22 Jun 2021 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4/MYlg+l4edMbeWoa4sr+R1MP+N7EcYv7KKX/Y2Zq/Y=;
        b=V4Dv3CHjaIpXBIzzgxJcZhshdF5aEDawH75NxknuNpKPaRAURqRMeGksBg6oD1k6kb
         b7OC2dOvp5+n7306HX+apLfiARUZkWC8IKNcpUhgpAlysxSVdmPi16BcobOJWr9i6pKp
         X44uJu7ULUsWU1/Fnfnp7Z06pfmB+oDUOttQYyl3Otdk93YJQ2sS8y37zZ252+Y5PNRw
         AzyhKVn7VmFm+VudptO/38iiYIDQgUX9v844zWxDj+hS+me0OxoOtaeFxLjAaovlkkb9
         PZ4Q/7pE/DOfLA3fXxpfEMjYhxYpenPP9duHxJQ9Od7OW9Y8uOAPNOqVaBE8qi6AYt2U
         dY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4/MYlg+l4edMbeWoa4sr+R1MP+N7EcYv7KKX/Y2Zq/Y=;
        b=GZdh9coUEaZzwxyF926lxyec6gMURxCSvpMorxKPGeqEhR34krs1CEYqqtuVQ1T/n6
         TQWNqthHpVro2SeHFrI83dT2e/2sfx4cYmvC+k12OA1HeU8V/+EVuWw0BEdfT1rdsiSy
         8kOeMZ1jLsPUeZnXnlqKOzHXzVMW4AF+jVDcsIFJMew3fJrMlg9QTZAt/NkNiiXhBdmC
         BHCanaN9uxIPZjXxCUrqaDm204ZQQvNeoYfWRYb6YMahfOtTX6F3Y9bqkTJyP20mHMfO
         WqtAmurWqzpJxOQyPb9H1t5H4OjFzUdjub7M2Cdw2IC9ykEITF8AnwNjHzwAfdVTjTOe
         y2WA==
X-Gm-Message-State: AOAM530KelTDMgDh2b3fAFqSTpdNukHD29/RcutVNWWl4gsfkwXqdl3R
        7GahjR1A76bgOPKAbimegeM=
X-Google-Smtp-Source: ABdhPJy9RPE96Mf4U/NtaPJQ5KDQ3f+Gd6S2Yeqz1pf+kN2172xJUtOQFw9yDBippgHQQgmh/RcZHA==
X-Received: by 2002:a62:7e4e:0:b029:303:d6c:f967 with SMTP id z75-20020a627e4e0000b02903030d6cf967mr4996535pfc.59.1624387914467;
        Tue, 22 Jun 2021 11:51:54 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d16sm3072212pjs.33.2021.06.22.11.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:51:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YNItqqZA9Y1wOnZY@casper.infradead.org>
Date:   Tue, 22 Jun 2021 11:51:51 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ted Ts'o <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F78E1A78-DB7E-4F3A-8C7C-842AA757E4FE@gmail.com>
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk>
 <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk>
 <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk>
 <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com>
 <YNIqjhsvEms6+vk9@casper.infradead.org>
 <CAHk-=wiRumzeOn1Fk-m-FiGf+sA0dSS3YPu--KAkT8-5W5yEHA@mail.gmail.com>
 <YNItqqZA9Y1wOnZY@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 22, 2021, at 11:36 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Tue, Jun 22, 2021 at 11:28:30AM -0700, Linus Torvalds wrote:
>> On Tue, Jun 22, 2021 at 11:23 AM Matthew Wilcox <willy@infradead.org> =
wrote:
>>>=20
>>> It wouldn't be _that_ bad necessarily.  filemap_fault:
>>=20
>> It's not actually the mm code that is the biggest problem. We
>> obviously already have readahead support.
>>=20
>> It's the *fault* side.
>>=20
>> In particular, since the fault would return without actually filling
>> in the page table entry (because the page isn't ready yet, and you
>> cannot expose it to other threads!), you also have to jump over the
>> instruction that caused this all.
>=20
> Oh, I was assuming that it'd be a function call like
> get_user_pages_fast(), not an instruction that was specially marked to
> be jumped over.  Gag reflex diminishing now?

Just reminding the alternative (in the RFC that I mentioned before):
a vDSO exception table entry for a memory accessing function in the
vDSO. It then behaves as a sort of MADV_WILLNEED for the faulting
page if an exception is triggered. Unlike MADV_WILLNEED it maps the
page if no IO is needed. It can return through a register whether
the page was present or not.

I once implemented (another) alternative, in which the ELF had a section
with an exception-table (holding all the =E2=80=9CAsync-#PF=E2=80=9D =
instructions),
which described where to skip to if a #PF occurs, but this solution
seemed too heavy-weight/intrusive.

