Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735F81F48DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgFIV2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgFIV2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:28:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15DC05BD1E;
        Tue,  9 Jun 2020 14:28:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so17298285ljv.5;
        Tue, 09 Jun 2020 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMUIJCyAqiPErssvu2L4X70mhx2mJmk33ZrJaC7iHl8=;
        b=ixMuTh3wC52nziHr1AA8Ptym0DwImvA5Gbg9FprvpGpk4XEsPdKEn81JQuZvBQTVV8
         ZGhial+5eg61qPtzJ2RFiLA8GmjhTNPrp4oeS5qodA1ahgbIpYd1pApRC3PW/DEv+mUb
         cE8rNh8EBFhv7mlfADNFyobWiuPmrNoxkT9md5V+sPQbxmu7LggVRWQ51GXukJ9CD7NK
         O58a3IP4RLbmeqkpQ1esMmtTvtU0gaWb9ux8vNBpfTJaB81dNuRt24dLZKBLJaTgIfJY
         KWAogPnxwJexTyN9V0PzOS+J52niSis2gm6UWfXAuQhYuZ8oFzqbryqfB0Zk1Pnnk5ZU
         suCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMUIJCyAqiPErssvu2L4X70mhx2mJmk33ZrJaC7iHl8=;
        b=h2rNrMq6ztkmzJh/ftZ33AkUMPtHneskEuZD7z43VQ6kZY2bbGN6V+yltp8X5v88E3
         tgIYvS/m7W0RnBe4EovE3dVeMKq5t7MQzbfPVZooJ4ocrxlmxvOeBPKBy1y5PTWZglXQ
         iedPspw+lhW8cP9KgAGeVYP9wzMmLIRt8MaJl1bXIRA8qOsPpllyaafOyPZqu33y77gr
         sygRruruvUv2DBql4pJCySMPD4c1W/LTDB72i/eqmj+nYn3nkyVycH+Jwo9deVrIx1pf
         NYY+N2JSj1KJhrS/vlPGOT+ihhzZ3AgftvaZ2FIj3NRmMkyWvNM5z6gRFqqjH0XQbSlC
         H4Uw==
X-Gm-Message-State: AOAM530jGHq8Ct7r+ViYiMBC8aNBedZteXcWlKFR5NVrY3WAUChA+wKX
        aOhN9iAG68Au52uEwl3Ma8w=
X-Google-Smtp-Source: ABdhPJyfm1gS5UDR0tbQFtaSDNPx+/jZhgqUkTjRW/RLxOx3piwWnfIEN4ld2nuiQDXw47IHZk86ig==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr104128lji.255.1591738100422;
        Tue, 09 Jun 2020 14:28:20 -0700 (PDT)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q190sm4502784ljb.29.2020.06.09.14.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 14:28:19 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id A77441A1EC1; Wed, 10 Jun 2020 00:28:18 +0300 (MSK)
Date:   Wed, 10 Jun 2020 00:28:18 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609212818.GM134822@grain>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609184517.GL134822@grain>
 <cda72e8402244a85862f95ea84ff9204@EXMBDFT11.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda72e8402244a85862f95ea84ff9204@EXMBDFT11.ad.twosigma.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:09:49PM +0000, Nicolas Viennot wrote:
> >>  proc_map_files_get_link(struct dentry *dentry,
> >>  			struct inode *inode,
> >>  		        struct delayed_call *done)
> >>  {
> >> -	if (!capable(CAP_SYS_ADMIN))
> >> +	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
> >>  		return ERR_PTR(-EPERM);
> 
> > First of all -- sorry for late reply. You know, looking into this code more I think
> this CAP_SYS_ADMIN is simply wrong: for example I can't even fetch links for /proc/self/map_files.
> Still /proc/$pid/maps (which as well points to the files opened) test for ptrace-read permission.
> I think we need ptrace-may-attach test here instead of these capabilities (if I can attach to
> a process I can read any data needed, including the content of the mapped files, if only
> I'm not missing something obvious).
> 

Nikolas, could you please split the text lines next time, I've had to add newlines into reply manually :)

> Currently /proc/pid/map_files/* have exactly the same permission checks as /proc/pid/fd/*, with the exception
> of the extra CAP_SYS_ADMIN check. The check originated from the following discussions where 3 security issues are discussed:
> http://lkml.iu.edu/hypermail/linux/kernel/1505.2/02524.html
> http://lkml.iu.edu/hypermail/linux/kernel/1505.2/04030.html
> 
> From what I understand, the extra CAP_SYS_ADMIN comes from the following issues:
> 1. Being able to open dma-buf / kdbus region (referred in the referenced email as problem #1).
> I don't fully understand what the dangers are, but perhaps we could do CAP_SYS_ADMIN check
> only for such dangerous files, as opposed to all files.

As far as I remember we only need to read the content of mmap'ed files and if I've ptrace-attach
permission we aready can inject own code into a process and read anything we wish. That said we probably
should fixup this interface like -- test for open mode and if it is read only then ptrace-attach
should be enough, if it is write mode -- then we require being node's admin instead of just adding
a new capability here. And thanks a huge for mail reference, I'll take a look once time permit.
