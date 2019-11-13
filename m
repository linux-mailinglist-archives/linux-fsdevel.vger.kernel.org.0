Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48ECFBBD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKMWsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 17:48:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46633 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfKMWsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:48:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so4240590wrs.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lZTpS2joYk+fUmESBGaQbCu+yB8VwBrfz0zrdA9q1TQ=;
        b=BzjIduangPFvAzZWgR203MjIM7WWi0HEh94XzWGlBunGkjxbJV1Zb2XDd0K0Q5XjiG
         ImPnXGqv6nIpyOuNTdvhk8IXCAF96XveyxUFVxTlMHJZzhL2jGsSPcMWFb3i+uFgnoY4
         PES0M9eDn+cmqL+60VQQsXI3NArqGkEfkq4gY9q0HsYCWuLwSIUOGmSf4B2iY5awX7Z3
         mWacf2zQyuAFyeVaYr1cnmKKDmGfJ6ZoV0zjlZHzV/TyDl2LK9ev5EIfC1dCGDv2FZc+
         PWH/mh8PT+a84SywJNRMstDzBKvK70cxyXhjK1fbiUp/1yXBPISA494u9cOq8B9BOOct
         UdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZTpS2joYk+fUmESBGaQbCu+yB8VwBrfz0zrdA9q1TQ=;
        b=nNHwhhYiJJccsgsbw2NdogOYMTQi92mzPx6u6DRttlCVGua1NuzpcrBSsWO7HRPQxJ
         HxgvkqM8wygCaijqBlZ24KXzu8WmqF4XldfR0tvFLwofbzOQrlExGsMWB/zjLdVgDz0P
         gYzhp9CEQV5QqgR7DyBCcOogQru401eYjT+L11Rgb+ujFXhUY98/CVFlU3eQ9hijnAgQ
         LmBo7qYYb5Jp61HF9I19QCnB8njAOg2meXSvZbpcavmee1p3e8L07JyfKCRXOVNZPBEF
         XSFiMeiB5S2VKsD9fqA9HCECkkU7ijyUCyId83KQTRKdiQVoq9tk92HsNoMWxxDgpUFw
         znSg==
X-Gm-Message-State: APjAAAWl9dzGKLF8cpVN1Bdrzki2PZtN9pTiziA4jnsKo3PAQXb9ZKYG
        I9oh8qrRksiMWNd80dMqU/i3Hg==
X-Google-Smtp-Source: APXvYqwFsMji4u3hw0Z4MSh0J9JR7kvK3Li3GIVW3HMwtqb59PAUp9qoogj4uvt5Jc4Or70UQAJ13g==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr5444884wrw.141.1573685294877;
        Wed, 13 Nov 2019 14:48:14 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v9sm4447145wrs.95.2019.11.13.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 14:48:13 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:48:08 +0100
From:   Marco Elver <elver@google.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Message-ID: <20191113224808.GA3960@google.com>
References: <20191113213336.GA20665@google.com>
 <Pine.LNX.4.44L0.1911131648010.1558-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1911131648010.1558-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Nov 2019, Alan Stern wrote:

> On Wed, 13 Nov 2019, Marco Elver wrote:
> 
> > An expression works fine. The below patch would work with KCSAN, and all
> > your above examples work.
> > 
> > Re name: would it make sense to more directly convey the intent?  I.e.
> > "this expression can race, and it's fine that the result is approximate
> > if it does"?
> > 
> > My vote would go to something like 'smp_lossy' or 'lossy_race' -- but
> > don't have a strong preference, and would also be fine with 'data_race'.
> > Whatever is most legible.  Comments?
> 
> Lossiness isn't really relevant.  Things like sticky writes work 
> perfectly well with data races; they don't lose anything.
> 
> My preference would be for "data_race" or something very similar
> ("racy"? "race_ok"?).  That's the whole point -- we know the
> operation can be part of a data race and we don't care.

Makes sense. Let's stick with 'data_race' then.

As Linus pointed out this won't yet work for void types and
if-statements. How frequent would that use be? Should it even be
encouraged?

I'll add this as a patch for the next version of the KCSAN patch series.

Thanks,
-- Marco

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0b6506b9dd11..a97f323b61e3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -308,6 +308,26 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
+#include <linux/kcsan.h>
+
+/*
+ * data_race: macro to document that accesses in an expression may conflict with
+ * other concurrent accesses resulting in data races, but the resulting
+ * behaviour is deemed safe regardless.
+ *
+ * This macro *does not* affect normal code generation, but is a hint to tooling
+ * that data races here are intentional.
+ */
+#define data_race(expr)                                                      \
+	({                                                                     \
+		typeof(({ expr; })) __val;                                     \
+		kcsan_nestable_atomic_begin();                                 \
+		__val = ({ expr; });                                           \
+		kcsan_nestable_atomic_end();                                   \
+		__val;                                                         \
+	})
+#else
+
 #endif /* __KERNEL__ */
 
 /*
