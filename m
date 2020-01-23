Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A811461FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 07:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAWG1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 01:27:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2491 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgAWG1H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 01:27:07 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483C3s270Bz9v0vB;
        Thu, 23 Jan 2020 07:27:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qDUreYcv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 88agPtHElRwH; Thu, 23 Jan 2020 07:27:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483C3s0xK1z9v0v9;
        Thu, 23 Jan 2020 07:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579760825; bh=+JkacBp8xGLVJ+/XN1IrJUelPycgDc81GD+/7UFttpw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qDUreYcveQN7gkbU+RuAbIMMqLqZ82rgNMtClWvQ8ePujCDqYxvkFik+8fnkC18sG
         gZNT3xq7kQCiAg6BdKA+RiMh2IRDP/xc2PC6WjWartHwRR2V8S3tnKhPj2O6M2BBzD
         yBYVxAK+65cOfxEa9jp2d+CKb17Lm1Il6wiJffuQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED7F08B81A;
        Thu, 23 Jan 2020 07:27:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u2yqNAN-A3Tc; Thu, 23 Jan 2020 07:27:05 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 601238B75B;
        Thu, 23 Jan 2020 07:27:04 +0100 (CET)
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <CAHk-=wgNQ-rWoLg0OCJYYYbKBnRAUK4NPU-OD+vv-6fWnd=8kA@mail.gmail.com>
 <CAHk-=winQ_607Sp09H1w70A_WPmt7ydxrNrwvk=N29S=FpASZw@mail.gmail.com>
 <CAHk-=whzabmci2b7ras3RcMpimvzNAk4QHDcYf=irvwXnunS8w@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <75590182-8291-9030-c0bf-b11c6b4fccec@c-s.fr>
Date:   Thu, 23 Jan 2020 07:27:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whzabmci2b7ras3RcMpimvzNAk4QHDcYf=irvwXnunS8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 22/01/2020 à 21:37, Linus Torvalds a écrit :
> [ Talking to myself ]
> 
> On Wed, Jan 22, 2020 at 12:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> COMPLETELY UNTESTED! It compiles for me. The generated assembly looks
>> ok from a quick look.
> 
> 
> So here's a slightly updated patch that does exactly that, and avoids
> the objtool warning.
> 
> It actually generates better code than the last one too, because now
> we don't duplicate the user_access_end() for the EINTR case.
> 
> So test this one instead, please.

This patch works on my ppc board, thanks

Christophe
