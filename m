Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5C5C1DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfGARU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:20:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36033 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfGARU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:20:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so354113wmm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2019 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RMtO9zTMwULPwpFiTkeooNGzR9zKo/UB7YgL+t4fgzA=;
        b=1wUdmopYsOTGEBPctCCQBJNp/Weny3U0OdMAgIX7XMpDLNjX7yi2BQKVOeIOZfgf1b
         I2dQPvs1YcMd4MKfGasxoR1vUF57n1uWvGfOwCBn+dFFXqdtzk7+nDTMfgxaIC1cMqAd
         CyXSD5wWJrsSE7f66iNNQpS8suPAgj9SNlBFoRgvaYPLl2O9hulyvjxbO8s6Guhj4y1S
         Nf6nnLqhsslQUJQ8lQjHCR002MedRLPvKNFje/NywIlwBVxr1dbYLS/Ag6d45MoLEFLA
         TB43Jl9ECXn6C3ClznsgSlBckfDR8AQM1se/327D0FreZlmY9S9DkHpcHai8gVFUiAbk
         jAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RMtO9zTMwULPwpFiTkeooNGzR9zKo/UB7YgL+t4fgzA=;
        b=lbRYxOgcPHIZPivmiYRMNeiM+90EUAswD850SQA9njrdcQME/BFshYuB7CgZ1Mn0L4
         ixcb3gRwXBBWxVDiODODv5AQeAPj+NISnzqmFBv1pwYchzRHKDutUSZqG59iMxrEzEu0
         xuRSslOD1fnvtgt1NeqOsI27kef9OSafZzolI+J4kxjk2aDMNaBWfhpBeJmz5QUJ45XC
         Rchb19sX4EyUrMuaq57jPLnKqoiU9QXkrCywKQyIaAoqnA+vmEC57MafZduIDtivSMZH
         H0qWiGuMS6VFAijNMdwZIx260ekRbmXJcTIIGw8SFR0WGfoJ+ffLsYkiRFqyiULiLNiR
         JW3A==
X-Gm-Message-State: APjAAAUNYa4UoTNnZaAqTJ+4keHQwlxcYy26QEzGSoAWCnX+ibDC3R95
        +cy0eVlIB60qlpeKwC0B0WkiMw==
X-Google-Smtp-Source: APXvYqyJIZEjZ99B+K6R50DPm7lq0IHr/E/1lfJMHdrHDPCDWuYMn1JV6lQAB5xdWdZjMaq23hnwbA==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr234245wmb.32.1562001657000;
        Mon, 01 Jul 2019 10:20:57 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id q193sm269299wme.8.2019.07.01.10.20.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 10:20:56 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] vfs: make immutable files actually immutable
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, hch@infradead.org,
        clm@fb.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk,
        jack@suse.com, dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org
Cc:     reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <156174687561.1557469.7505651950825460767.stgit@magnolia>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <72f01c73-a1eb-efde-58fa-7667221255c7@plexistor.com>
Date:   Mon, 1 Jul 2019 20:20:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <156174687561.1557469.7505651950825460767.stgit@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/06/2019 21:34, Darrick J. Wong wrote:
> Hi all,
> 
> The chattr(1) manpage has this to say about the immutable bit that
> system administrators can set on files:
> 
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
> 
> Given the clause about how the file 'cannot be modified', it is
> surprising that programs holding writable file descriptors can continue
> to write to and truncate files after the immutable flag has been set,
> but they cannot call other things such as utimes, fallocate, unlink,
> link, setxattr, or reflink.
> 
> Since the immutable flag is only settable by administrators, resolve
> this inconsistent behavior in favor of the documented behavior -- once
> the flag is set, the file cannot be modified, period.  We presume that
> administrators must be trusted to know what they're doing, and that
> cutting off programs with writable fds will probably break them.
> 

This effort sounds very logical to me and sound. But are we allowed to
do it? IE: Is it not breaking ABI. I do agree previous ABI was evil but
are we allowed to break it?

I would not mind breaking it if %99.99 of the time the immutable bit
was actually set manually by a human administrator. But what if there
are automated systems that set it relying on the current behaviour?

For example I have a very distant and vague recollection of a massive
camera capture system, that was DMAing directly to file (splice). And setting
the immutable bit right away on start. Then once the capture is done
(capture file recycled) the file becomes immutable. Such program is now
broken. Who's fault is it?

I'm totally not sure and maybe you are right. But have you made a
survey of the majority of immutable uses, and are positive that
the guys are not broken after this change?

For me this is kind of scary. Yes I am known to be a SW coward ;-)

Thanks
Boaz
