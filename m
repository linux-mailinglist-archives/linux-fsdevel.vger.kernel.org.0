Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1869110DEB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfK3S4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 13:56:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3S4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dtDNU5sJrpQrH2YZuWtZnAQZGfS/Szp5dKIJMLrH2NQ=; b=bEeUz/nIiuE8mV7phq5Zje58L
        F52B0xp4sOqF2KbwO12ZLwt/L8jYT4xIBG7E7pOIEq118Aw5Szw36Q70sZimDGjoCge9T9gdrAiUx
        sxo69Ft81pZGFQzOE5cKSmGT+gza4H7/F63XE1j7JNX1vX27RDV/s7AF6P5xc2AwZ57vESvhG0KC/
        pJLBFu6XUNpKaARxLaK2cQjijzY9SVdKQ/k9q6Fb/yl7DqFRUk0utdzX2rnr5ayxtP05M9tDIVuLp
        fegOXw6NzVHi+XVCFofCuSS8+iB6wmda7bsLY1WUH1dLXnefI7bpyvBc0PY1TytoT4NubG5SY/X4u
        aFvb7Cg1w==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ib7vE-0006e1-Gi; Sat, 30 Nov 2019 18:56:48 +0000
Subject: Re: Regression in squashfs mount option handling in v5.4
To:     Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
References: <20191130181548.GA28459@gentoo-tp.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6af16095-eab0-9e99-6782-374705d545e4@infradead.org>
Date:   Sat, 30 Nov 2019 10:56:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130181548.GA28459@gentoo-tp.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding Cc-s]

On 11/30/19 10:15 AM, Jeremi Piotrowski wrote:
> Hi,
> 
> I'm working on an embedded project which uses 'rauc' as an updater. rauc mounts
> a squashfs image using
> 
>   mount -t squashfs -o ro,loop,sizelimit=xxx squashfs.img /mnt
> 
> On my system mount is busybox, and busybox does not know the sizelimit
> parameter, so it simply passes it on to the mount syscall. The syscall
> arguments end up being:
> 
>   mount("/dev/loop0", "dir", "squashfs", MS_RDONLY|MS_SILENT, "sizelimit=xxx")
> 
> Until kernel 5.4 this worked, since 5.4 this returns EINVAL and dmesg contains
> the line "squashfs: Unknown parameter 'sizelimit'". I believe this has to do
> with the conversion of squashfs to the new mount api. 
> 
> This is an unfortunate regression, and it does not seem like this can be simply
> reverted. What is the suggested course of action?
> 
> Please cc me on replies, I'm not subscribed to the list.
> 
> Thanks,
> Jeremi
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
