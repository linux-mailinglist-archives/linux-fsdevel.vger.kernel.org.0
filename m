Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C72259E43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgIASk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 14:40:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19673 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIASkZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:40:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BgwpW6ZwSz9tyNc;
        Tue,  1 Sep 2020 20:39:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id a9wJEA4sXnrt; Tue,  1 Sep 2020 20:39:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BgwpW4v6Mz9tyNb;
        Tue,  1 Sep 2020 20:39:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 746018B7EF;
        Tue,  1 Sep 2020 20:39:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5nTmBMNGc5Ho; Tue,  1 Sep 2020 20:39:31 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B8498B7EE;
        Tue,  1 Sep 2020 20:39:30 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v2
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200827150030.282762-1-hch@lst.de>
 <a8bb0319-0928-4687-9e9c-777c5860dbdd@csgroup.eu>
 <20200901172512.GI1236603@ZenIV.linux.org.uk>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a5c04aeb-c316-ba46-de2c-fabf638f11d9@csgroup.eu>
Date:   Tue, 1 Sep 2020 20:39:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901172512.GI1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 01/09/2020 à 19:25, Al Viro a écrit :
> On Tue, Sep 01, 2020 at 07:13:00PM +0200, Christophe Leroy wrote:
> 
>>      10.92%  dd       [kernel.kallsyms]  [k] iov_iter_zero
> 
> Interesting...  Could you get an instruction-level profile inside iov_iter_zero(),
> along with the disassembly of that sucker?
> 

Output of perf annotate:


  Percent |	Source code & Disassembly of vmlinux for cpu-clock (3579 
samples)
---------------------------------------------------------------------------------
          :
          :
          :
          :	Disassembly of section .text:
          :
          :	c02cb3a4 <iov_iter_zero>:
          :	iov_iter_zero():
     2.24 :	  c02cb3a4:       stwu    r1,-80(r1)
     0.31 :	  c02cb3a8:       stw     r30,72(r1)
     0.00 :	  c02cb3ac:       mr      r30,r4
     0.11 :	  c02cb3b0:       stw     r31,76(r1)
     0.00 :	  c02cb3b4:       mr      r31,r3
     1.06 :	  c02cb3b8:       stw     r27,60(r1)
          :	iov_iter_type():
     0.03 :	  c02cb3bc:       lwz     r10,0(r4)
     0.06 :	  c02cb3c0:       rlwinm  r9,r10,0,0,30
          :	iov_iter_zero():
     0.03 :	  c02cb3c4:       cmpwi   r9,32
     0.00 :	  c02cb3c8:       lwz     r9,624(r2)
     2.15 :	  c02cb3cc:       stw     r9,28(r1)
     0.00 :	  c02cb3d0:       li      r9,0
     0.00 :	  c02cb3d4:       beq     c02cb520 <iov_iter_zero+0x17c>
     0.14 :	  c02cb3d8:       lwz     r9,8(r4)
     0.08 :	  c02cb3dc:       cmplw   r9,r3
     0.00 :	  c02cb3e0:       mr      r27,r9
     0.03 :	  c02cb3e4:       bgt     c02cb4fc <iov_iter_zero+0x158>
     1.34 :	  c02cb3e8:       cmpwi   r9,0
     0.00 :	  c02cb3ec:       beq     c02cb4d0 <iov_iter_zero+0x12c>
     0.11 :	  c02cb3f0:       andi.   r8,r10,16
     0.17 :	  c02cb3f4:       lwz     r31,4(r30)
     1.79 :	  c02cb3f8:       bne     c02cb61c <iov_iter_zero+0x278>
     0.00 :	  c02cb3fc:       andi.   r8,r10,8
     0.06 :	  c02cb400:       bne     c02cb770 <iov_iter_zero+0x3cc>
     0.22 :	  c02cb404:       andi.   r10,r10,64
     0.03 :	  c02cb408:       bne     c02cb88c <iov_iter_zero+0x4e8>
     0.11 :	  c02cb40c:       stw     r29,68(r1)
     1.59 :	  c02cb410:       stw     r28,64(r1)
     0.03 :	  c02cb414:       lwz     r28,12(r30)
     0.00 :	  c02cb418:       lwz     r7,4(r28)
     1.87 :	  c02cb41c:       subf    r29,r31,r7
     0.28 :	  c02cb420:       cmplw   r29,r27
     0.03 :	  c02cb424:       bgt     c02cb50c <iov_iter_zero+0x168>
     0.03 :	  c02cb428:       cmpwi   r29,0
     0.00 :	  c02cb42c:       beq     c02cb898 <iov_iter_zero+0x4f4>
     1.34 :	  c02cb430:       lwz     r3,0(r28)
          :	__access_ok():
     0.00 :	  c02cb434:       lis     r10,-16384
          :	iov_iter_zero():
     0.36 :	  c02cb438:       add     r3,r3,r31
          :	__access_ok():
     0.03 :	  c02cb43c:       cmplw   r3,r10
     1.79 :	  c02cb440:       bge     c02cb514 <iov_iter_zero+0x170>
    13.19 :	  c02cb444:       subf    r10,r3,r10
          :	clear_user():
     0.00 :	  c02cb448:       cmplw   r29,r10
     4.41 :	  c02cb44c:       mflr    r0
     0.00 :	  c02cb450:       stw     r0,84(r1)
     0.00 :	  c02cb454:       bgt     c02cb8c4 <iov_iter_zero+0x520>
     0.00 :	  c02cb458:       mr      r4,r29
     0.00 :	  c02cb45c:       bl      c001a41c <__arch_clear_user>
          :	iov_iter_zero():
     0.70 :	  c02cb460:       add     r31,r31,r29
     0.00 :	  c02cb464:       cmpwi   r3,0
    17.13 :	  c02cb468:       subf    r29,r29,r27
     0.00 :	  c02cb46c:       subf    r31,r3,r31
     1.20 :	  c02cb470:       add     r29,r29,r3
     0.00 :	  c02cb474:       beq     c02cb8b8 <iov_iter_zero+0x514>
     0.00 :	  c02cb478:       lwz     r9,8(r30)
     0.00 :	  c02cb47c:       subf    r10,r27,r29
     0.00 :	  c02cb480:       lwz     r0,84(r1)
     0.00 :	  c02cb484:       subf    r27,r29,r27
     0.00 :	  c02cb488:       add     r9,r10,r9
     0.00 :	  c02cb48c:       lwz     r7,4(r28)
     0.00 :	  c02cb490:       lwz     r10,12(r30)
     0.00 :	  c02cb494:       mtlr    r0
     1.65 :	  c02cb498:       cmplw   r31,r7
    14.61 :	  c02cb49c:       bne     c02cb4a8 <iov_iter_zero+0x104>
     1.65 :	  c02cb4a0:       addi    r28,r28,8
     0.00 :	  c02cb4a4:       li      r31,0
    14.92 :	  c02cb4a8:       lwz     r8,16(r30)
     0.00 :	  c02cb4ac:       subf    r10,r10,r28
     1.12 :	  c02cb4b0:       srawi   r10,r10,3
     0.56 :	  c02cb4b4:       stw     r28,12(r30)
     0.00 :	  c02cb4b8:       subf    r10,r10,r8
     1.23 :	  c02cb4bc:       stw     r10,16(r30)
     0.00 :	  c02cb4c0:       lwz     r28,64(r1)
     0.56 :	  c02cb4c4:       lwz     r29,68(r1)
     0.00 :	  c02cb4c8:       stw     r9,8(r30)
     2.12 :	  c02cb4cc:       stw     r31,4(r30)
     0.00 :	  c02cb4d0:       lwz     r9,28(r1)
     0.61 :	  c02cb4d4:       lwz     r10,624(r2)
     0.00 :	  c02cb4d8:       xor.    r9,r9,r10
     0.00 :	  c02cb4dc:       li      r10,0
     0.00 :	  c02cb4e0:       bne     c02cb9a8 <iov_iter_zero+0x604>
     0.00 :	  c02cb4e4:       mr      r3,r27
     0.00 :	  c02cb4e8:       lwz     r30,72(r1)
     1.73 :	  c02cb4ec:       lwz     r27,60(r1)
     0.50 :	  c02cb4f0:       lwz     r31,76(r1)
     0.00 :	  c02cb4f4:       addi    r1,r1,80
     0.00 :	  c02cb4f8:       blr
     0.00 :	  c02cb4fc:       cmpwi   r9,0
     0.00 :	  c02cb500:       mr      r27,r3
     0.00 :	  c02cb504:       beq     c02cb4d0 <iov_iter_zero+0x12c>
     0.00 :	  c02cb508:       b       c02cb3f0 <iov_iter_zero+0x4c>
     0.00 :	  c02cb50c:       mr      r29,r27
     0.00 :	  c02cb510:       b       c02cb428 <iov_iter_zero+0x84>
          :	__access_ok():
     0.00 :	  c02cb514:       li      r27,0
     0.00 :	  c02cb518:       mr      r10,r28
     0.00 :	  c02cb51c:       b       c02cb498 <iov_iter_zero+0xf4>
          :	pipe_zero():
     0.00 :	  c02cb520:       mflr    r0
     0.00 :	  c02cb524:       stw     r26,56(r1)
     0.00 :	  c02cb528:       stw     r0,84(r1)
     0.00 :	  c02cb52c:       mr      r3,r4
     0.00 :	  c02cb530:       stw     r28,64(r1)
     0.00 :	  c02cb534:       lwz     r28,12(r4)
     0.00 :	  c02cb538:       lwz     r26,40(r28)
     0.00 :	  c02cb53c:       bl      c02c8e48 <sanity>
     0.00 :	  c02cb540:       cmpwi   r3,0
     0.00 :	  c02cb544:       bne     c02cb560 <iov_iter_zero+0x1bc>
     0.00 :	  c02cb548:       lwz     r0,84(r1)
     0.00 :	  c02cb54c:       li      r27,0
     0.00 :	  c02cb550:       lwz     r26,56(r1)
     0.00 :	  c02cb554:       lwz     r28,64(r1)
     0.00 :	  c02cb558:       mtlr    r0
     0.00 :	  c02cb55c:       b       c02cb4d0 <iov_iter_zero+0x12c>
     0.00 :	  c02cb560:       mr      r4,r31
     0.00 :	  c02cb564:       addi    r6,r1,24
     0.00 :	  c02cb568:       addi    r5,r1,20
     0.00 :	  c02cb56c:       mr      r3,r30
     0.00 :	  c02cb570:       bl      c02c9030 <push_pipe>
     0.00 :	  c02cb574:       mr.     r27,r3
     0.00 :	  c02cb578:       beq     c02cb548 <iov_iter_zero+0x1a4>
     0.00 :	  c02cb57c:       lwz     r4,24(r1)
     0.00 :	  c02cb580:       addi    r26,r26,-1
     0.00 :	  c02cb584:       lwz     r9,20(r1)
     0.00 :	  c02cb588:       stw     r25,52(r1)
     0.00 :	  c02cb58c:       li      r25,0
     0.00 :	  c02cb590:       stw     r29,68(r1)
     0.00 :	  c02cb594:       mr      r29,r27
     0.00 :	  c02cb598:       subfic  r31,r4,4096
     0.00 :	  c02cb59c:       cmplw   r31,r29
     0.00 :	  c02cb5a0:       ble     c02cb5a8 <iov_iter_zero+0x204>
     0.00 :	  c02cb5a4:       mr      r31,r29
     0.00 :	  c02cb5a8:       and     r9,r26,r9
     0.00 :	  c02cb5ac:       lwz     r8,80(r28)
     0.00 :	  c02cb5b0:       rlwinm  r10,r9,1,0,30
     0.00 :	  c02cb5b4:       add     r9,r10,r9
     0.00 :	  c02cb5b8:       rlwinm  r9,r9,3,0,28
     0.00 :	  c02cb5bc:       lwzx    r3,r8,r9
     0.00 :	  c02cb5c0:       mr      r5,r31
     0.00 :	  c02cb5c4:       bl      c02c92ec <memzero_page>
     0.00 :	  c02cb5c8:       subf.   r29,r31,r29
     0.00 :	  c02cb5cc:       lwz     r9,20(r1)
     0.00 :	  c02cb5d0:       li      r4,0
     0.00 :	  c02cb5d4:       lwz     r10,24(r1)
     0.00 :	  c02cb5d8:       stw     r9,16(r30)
     0.00 :	  c02cb5dc:       addi    r9,r9,1
     0.00 :	  c02cb5e0:       add     r10,r10,r31
     0.00 :	  c02cb5e4:       stw     r9,20(r1)
     0.00 :	  c02cb5e8:       stw     r10,4(r30)
     0.00 :	  c02cb5ec:       stw     r25,24(r1)
     0.00 :	  c02cb5f0:       bne     c02cb598 <iov_iter_zero+0x1f4>
     0.00 :	  c02cb5f4:       lwz     r9,8(r30)
     0.00 :	  c02cb5f8:       subf    r9,r27,r9
     0.00 :	  c02cb5fc:       stw     r9,8(r30)
          :	iov_iter_zero():
     0.00 :	  c02cb600:       lwz     r0,84(r1)
     0.00 :	  c02cb604:       lwz     r25,52(r1)
     0.00 :	  c02cb608:       lwz     r26,56(r1)
     0.00 :	  c02cb60c:       mtlr    r0
     0.00 :	  c02cb610:       lwz     r28,64(r1)
     0.00 :	  c02cb614:       lwz     r29,68(r1)
     0.00 :	  c02cb618:       b       c02cb4d0 <iov_iter_zero+0x12c>
     0.00 :	  c02cb61c:       stw     r23,44(r1)
     0.00 :	  c02cb620:       cmpwi   r27,0
     0.00 :	  c02cb624:       stw     r28,64(r1)
     0.00 :	  c02cb628:       mr      r23,r27
     0.00 :	  c02cb62c:       stw     r24,48(r1)
     0.00 :	  c02cb630:       li      r28,0
     0.00 :	  c02cb634:       lwz     r24,12(r30)
     0.00 :	  c02cb638:       mr      r8,r24
     0.00 :	  c02cb63c:       beq     c02cb714 <iov_iter_zero+0x370>
     0.00 :	  c02cb640:       mflr    r0
     0.00 :	  c02cb644:       stw     r25,52(r1)
     0.00 :	  c02cb648:       stw     r0,84(r1)
     0.00 :	  c02cb64c:       stw     r26,56(r1)
     0.00 :	  c02cb650:       stw     r29,68(r1)
     0.00 :	  c02cb654:       rlwinm  r25,r28,1,0,30
     0.00 :	  c02cb658:       add     r25,r25,r28
     0.00 :	  c02cb65c:       rlwinm  r25,r25,2,0,29
     0.00 :	  c02cb660:       add     r10,r8,r25
     0.00 :	  c02cb664:       lwz     r26,4(r10)
     0.00 :	  c02cb668:       mr      r29,r25
     0.00 :	  c02cb66c:       lwz     r9,8(r10)
     0.00 :	  c02cb670:       subf    r26,r31,r26
     0.00 :	  c02cb674:       cmplw   r26,r23
     0.00 :	  c02cb678:       add     r9,r31,r9
     0.00 :	  c02cb67c:       clrlwi  r4,r9,20
     0.00 :	  c02cb680:       ble     c02cb688 <iov_iter_zero+0x2e4>
     0.00 :	  c02cb684:       mr      r26,r23
     0.00 :	  c02cb688:       subfic  r7,r4,4096
     0.00 :	  c02cb68c:       cmplw   r26,r7
     0.00 :	  c02cb690:       ble     c02cb698 <iov_iter_zero+0x2f4>
     0.00 :	  c02cb694:       mr      r26,r7
     0.00 :	  c02cb698:       cmpwi   r26,0
     0.00 :	  c02cb69c:       beq     c02cb6c0 <iov_iter_zero+0x31c>
     0.00 :	  c02cb6a0:       lwz     r3,0(r10)
     0.00 :	  c02cb6a4:       rlwinm  r9,r9,25,7,26
     0.00 :	  c02cb6a8:       mr      r5,r26
     0.00 :	  c02cb6ac:       add     r3,r3,r9
     0.00 :	  c02cb6b0:       bl      c02c92ec <memzero_page>
          :	bvec_iter_advance():
     0.00 :	  c02cb6b4:       cmplw   r23,r26
          :	iov_iter_zero():
     0.00 :	  c02cb6b8:       lwz     r8,12(r30)
          :	bvec_iter_advance():
     0.00 :	  c02cb6bc:       blt     c02cb850 <iov_iter_zero+0x4ac>
     0.00 :	  c02cb6c0:       add.    r31,r31,r26
     0.00 :	  c02cb6c4:       subf    r23,r26,r23
     0.00 :	  c02cb6c8:       addi    r10,r8,4
     0.00 :	  c02cb6cc:       bne     c02cb6e4 <iov_iter_zero+0x340>
     0.00 :	  c02cb6d0:       b       c02cb6f0 <iov_iter_zero+0x34c>
     0.00 :	  c02cb6d4:       subf.   r31,r9,r31
     0.00 :	  c02cb6d8:       addi    r28,r28,1
     0.00 :	  c02cb6dc:       addi    r29,r29,12
     0.00 :	  c02cb6e0:       beq     c02cb760 <iov_iter_zero+0x3bc>
     0.00 :	  c02cb6e4:       lwzx    r9,r10,r29
     0.00 :	  c02cb6e8:       cmplw   r31,r9
     0.00 :	  c02cb6ec:       bge     c02cb6d4 <iov_iter_zero+0x330>
          :	iov_iter_zero():
     0.00 :	  c02cb6f0:       cmpwi   r23,0
     0.00 :	  c02cb6f4:       bne     c02cb654 <iov_iter_zero+0x2b0>
     0.00 :	  c02cb6f8:       add     r8,r8,r29
     0.00 :	  c02cb6fc:       lwz     r0,84(r1)
     0.00 :	  c02cb700:       lwz     r9,8(r30)
     0.00 :	  c02cb704:       lwz     r25,52(r1)
     0.00 :	  c02cb708:       mtlr    r0
     0.00 :	  c02cb70c:       lwz     r26,56(r1)
     0.00 :	  c02cb710:       lwz     r29,68(r1)
     0.00 :	  c02cb714:       subf    r24,r24,r8
     0.00 :	  c02cb718:       stw     r8,12(r30)
     0.00 :	  c02cb71c:       srawi   r6,r24,2
     0.00 :	  c02cb720:       lwz     r7,16(r30)
     0.00 :	  c02cb724:       rlwinm  r10,r24,0,0,29
     0.00 :	  c02cb728:       add     r10,r10,r6
     0.00 :	  c02cb72c:       rlwinm  r8,r10,4,0,27
     0.00 :	  c02cb730:       add     r10,r10,r8
     0.00 :	  c02cb734:       rlwinm  r8,r10,8,0,23
     0.00 :	  c02cb738:       add     r10,r10,r8
     0.00 :	  c02cb73c:       rlwinm  r8,r10,16,0,15
     0.00 :	  c02cb740:       add     r10,r10,r8
     0.00 :	  c02cb744:       add     r10,r7,r10
     0.00 :	  c02cb748:       stw     r10,16(r30)
     0.00 :	  c02cb74c:       subf    r9,r27,r9
     0.00 :	  c02cb750:       lwz     r23,44(r1)
     0.00 :	  c02cb754:       lwz     r24,48(r1)
     0.00 :	  c02cb758:       lwz     r28,64(r1)
     0.00 :	  c02cb75c:       b       c02cb4c8 <iov_iter_zero+0x124>
     0.00 :	  c02cb760:       rlwinm  r29,r28,1,0,30
     0.00 :	  c02cb764:       add     r29,r29,r28
     0.00 :	  c02cb768:       rlwinm  r29,r29,2,0,29
     0.00 :	  c02cb76c:       b       c02cb6f0 <iov_iter_zero+0x34c>
     0.00 :	  c02cb770:       mflr    r0
     0.00 :	  c02cb774:       stw     r26,56(r1)
     0.00 :	  c02cb778:       stw     r0,84(r1)
     0.00 :	  c02cb77c:       stw     r28,64(r1)
     0.00 :	  c02cb780:       stw     r29,68(r1)
     0.00 :	  c02cb784:       lwz     r28,12(r30)
     0.00 :	  c02cb788:       lwz     r29,4(r28)
     0.00 :	  c02cb78c:       subf    r29,r31,r29
     0.00 :	  c02cb790:       cmplw   r29,r27
     0.00 :	  c02cb794:       ble     c02cb79c <iov_iter_zero+0x3f8>
     0.00 :	  c02cb798:       mr      r29,r27
     0.00 :	  c02cb79c:       cmpwi   r29,0
     0.00 :	  c02cb7a0:       beq     c02cb8d8 <iov_iter_zero+0x534>
     0.00 :	  c02cb7a4:       lwz     r3,0(r28)
     0.00 :	  c02cb7a8:       mr      r5,r29
     0.00 :	  c02cb7ac:       li      r4,0
     0.00 :	  c02cb7b0:       add     r3,r3,r31
     0.00 :	  c02cb7b4:       subf    r26,r29,r27
     0.00 :	  c02cb7b8:       bl      c001999c <memset>
     0.00 :	  c02cb7bc:       add     r31,r31,r29
     0.00 :	  c02cb7c0:       cmpwi   r26,0
     0.00 :	  c02cb7c4:       bne     c02cb818 <iov_iter_zero+0x474>
     0.00 :	  c02cb7c8:       lwz     r9,4(r28)
     0.00 :	  c02cb7cc:       cmpw    r9,r31
     0.00 :	  c02cb7d0:       bne     c02cb7dc <iov_iter_zero+0x438>
     0.00 :	  c02cb7d4:       addi    r28,r28,8
     0.00 :	  c02cb7d8:       li      r31,0
     0.00 :	  c02cb7dc:       lwz     r9,12(r30)
     0.00 :	  c02cb7e0:       lwz     r8,16(r30)
     0.00 :	  c02cb7e4:       subf    r10,r9,r28
     0.00 :	  c02cb7e8:       stw     r28,12(r30)
     0.00 :	  c02cb7ec:       srawi   r10,r10,3
     0.00 :	  c02cb7f0:       lwz     r9,8(r30)
     0.00 :	  c02cb7f4:       subf    r10,r10,r8
     0.00 :	  c02cb7f8:       stw     r10,16(r30)
     0.00 :	  c02cb7fc:       subf    r9,r27,r9
     0.00 :	  c02cb800:       lwz     r0,84(r1)
     0.00 :	  c02cb804:       lwz     r26,56(r1)
     0.00 :	  c02cb808:       lwz     r28,64(r1)
     0.00 :	  c02cb80c:       mtlr    r0
     0.00 :	  c02cb810:       lwz     r29,68(r1)
     0.00 :	  c02cb814:       b       c02cb4c8 <iov_iter_zero+0x124>
     0.00 :	  c02cb818:       lwz     r31,12(r28)
     0.00 :	  c02cb81c:       addi    r28,r28,8
     0.00 :	  c02cb820:       cmplw   r31,r26
     0.00 :	  c02cb824:       ble     c02cb82c <iov_iter_zero+0x488>
     0.00 :	  c02cb828:       mr      r31,r26
     0.00 :	  c02cb82c:       cmpwi   r31,0
     0.00 :	  c02cb830:       beq     c02cb818 <iov_iter_zero+0x474>
     0.00 :	  c02cb834:       lwz     r3,0(r28)
     0.00 :	  c02cb838:       mr      r5,r31
     0.00 :	  c02cb83c:       li      r4,0
     0.00 :	  c02cb840:       bl      c001999c <memset>
     0.00 :	  c02cb844:       subf.   r26,r31,r26
     0.00 :	  c02cb848:       beq     c02cb7c8 <iov_iter_zero+0x424>
     0.00 :	  c02cb84c:       b       c02cb818 <iov_iter_zero+0x474>
          :	bvec_iter_advance():
     0.00 :	  c02cb850:       lis     r9,-16236
     0.00 :	  c02cb854:       lbz     r10,-20170(r9)
     0.00 :	  c02cb858:       cmpwi   r10,0
     0.00 :	  c02cb85c:       beq     c02cb868 <iov_iter_zero+0x4c4>
          :	iov_iter_zero():
     0.00 :	  c02cb860:       add     r8,r8,r25
     0.00 :	  c02cb864:       b       c02cb6fc <iov_iter_zero+0x358>
          :	bvec_iter_advance():
     0.00 :	  c02cb868:       lis     r3,-16253
     0.00 :	  c02cb86c:       li      r10,1
     0.00 :	  c02cb870:       addi    r3,r3,7580
     0.00 :	  c02cb874:       stb     r10,-20170(r9)
     0.00 :	  c02cb878:       bl      c0029b1c <__warn_printk>
     0.00 :	  c02cb87c:       twui    r0,0
          :	iov_iter_zero():
     0.00 :	  c02cb880:       lwz     r8,12(r30)
     0.00 :	  c02cb884:       add     r8,r8,r25
     0.00 :	  c02cb888:       b       c02cb6fc <iov_iter_zero+0x358>
     0.00 :	  c02cb88c:       add     r31,r31,r27
     0.00 :	  c02cb890:       subf    r9,r27,r9
     0.00 :	  c02cb894:       b       c02cb4c8 <iov_iter_zero+0x124>
     0.00 :	  c02cb898:       mr      r29,r27
     0.00 :	  c02cb89c:       cmpwi   r29,0
     1.65 :	  c02cb8a0:       bne     c02cb8e0 <iov_iter_zero+0x53c>
     0.00 :	  c02cb8a4:       lwz     r9,8(r30)
     0.53 :	  c02cb8a8:       lwz     r7,4(r28)
     0.00 :	  c02cb8ac:       lwz     r10,12(r30)
     0.00 :	  c02cb8b0:       subf    r9,r27,r9
     0.00 :	  c02cb8b4:       b       c02cb498 <iov_iter_zero+0xf4>
     0.25 :	  c02cb8b8:       lwz     r0,84(r1)
     2.26 :	  c02cb8bc:       mtlr    r0
     0.00 :	  c02cb8c0:       b       c02cb89c <iov_iter_zero+0x4f8>
          :	clear_user():
     0.00 :	  c02cb8c4:       lwz     r0,84(r1)
     0.00 :	  c02cb8c8:       li      r27,0
     0.00 :	  c02cb8cc:       mr      r10,r28
     0.00 :	  c02cb8d0:       mtlr    r0
     0.00 :	  c02cb8d4:       b       c02cb498 <iov_iter_zero+0xf4>
          :	iov_iter_zero():
     0.00 :	  c02cb8d8:       mr      r26,r27
     0.00 :	  c02cb8dc:       b       c02cb7c0 <iov_iter_zero+0x41c>
     0.00 :	  c02cb8e0:       stw     r26,56(r1)
     0.00 :	  c02cb8e4:       stw     r25,52(r1)
          :	__access_ok():
     0.00 :	  c02cb8e8:       lis     r25,-16384
          :	iov_iter_zero():
     0.00 :	  c02cb8ec:       lwz     r7,12(r28)
     0.00 :	  c02cb8f0:       addi    r26,r28,8
     0.00 :	  c02cb8f4:       mr      r31,r29
     0.00 :	  c02cb8f8:       cmplw   r29,r7
     0.00 :	  c02cb8fc:       ble     c02cb904 <iov_iter_zero+0x560>
     0.00 :	  c02cb900:       mr      r31,r7
     0.00 :	  c02cb904:       cmpwi   r31,0
     0.00 :	  c02cb908:       beq     c02cba04 <iov_iter_zero+0x660>
     0.00 :	  c02cb90c:       lwz     r3,0(r26)
          :	__access_ok():
     0.00 :	  c02cb910:       cmplw   r3,r25
     0.00 :	  c02cb914:       bge     c02cb980 <iov_iter_zero+0x5dc>
     0.00 :	  c02cb918:       subf    r9,r3,r25
          :	clear_user():
     0.00 :	  c02cb91c:       cmplw   r31,r9
     0.00 :	  c02cb920:       mflr    r0
     0.00 :	  c02cb924:       stw     r0,84(r1)
     0.00 :	  c02cb928:       bgt     c02cb978 <iov_iter_zero+0x5d4>
     0.00 :	  c02cb92c:       mr      r4,r31
     0.00 :	  c02cb930:       bl      c001a41c <__arch_clear_user>
          :	iov_iter_zero():
     0.00 :	  c02cb934:       subf    r29,r31,r29
     0.00 :	  c02cb938:       cmpwi   r3,0
     0.00 :	  c02cb93c:       subf    r31,r3,r31
     0.00 :	  c02cb940:       add     r29,r3,r29
     0.00 :	  c02cb944:       beq     c02cb9cc <iov_iter_zero+0x628>
     0.00 :	  c02cb948:       lwz     r9,8(r30)
     0.00 :	  c02cb94c:       subf    r8,r27,r29
     0.00 :	  c02cb950:       lwz     r0,84(r1)
     0.00 :	  c02cb954:       subf    r27,r29,r27
     0.00 :	  c02cb958:       lwz     r7,12(r28)
     0.00 :	  c02cb95c:       add     r9,r8,r9
     0.00 :	  c02cb960:       mr      r28,r26
     0.00 :	  c02cb964:       lwz     r10,12(r30)
     0.00 :	  c02cb968:       lwz     r25,52(r1)
     0.00 :	  c02cb96c:       mtlr    r0
     0.00 :	  c02cb970:       lwz     r26,56(r1)
     0.00 :	  c02cb974:       b       c02cb498 <iov_iter_zero+0xf4>
     0.00 :	  c02cb978:       lwz     r0,84(r1)
     0.00 :	  c02cb97c:       mtlr    r0
     0.00 :	  c02cb980:       lwz     r9,8(r30)
     0.00 :	  c02cb984:       subf    r8,r27,r29
     0.00 :	  c02cb988:       mr      r28,r26
     0.00 :	  c02cb98c:       lwz     r10,12(r30)
     0.00 :	  c02cb990:       lwz     r25,52(r1)
     0.00 :	  c02cb994:       add     r9,r8,r9
     0.00 :	  c02cb998:       lwz     r26,56(r1)
     0.00 :	  c02cb99c:       subf    r27,r29,r27
     0.00 :	  c02cb9a0:       li      r31,0
     0.00 :	  c02cb9a4:       b       c02cb498 <iov_iter_zero+0xf4>
     0.00 :	  c02cb9a8:       mflr    r0
     0.00 :	  c02cb9ac:       stw     r23,44(r1)
     0.00 :	  c02cb9b0:       stw     r0,84(r1)
     0.00 :	  c02cb9b4:       stw     r24,48(r1)
     0.00 :	  c02cb9b8:       stw     r25,52(r1)
     0.00 :	  c02cb9bc:       stw     r26,56(r1)
     0.00 :	  c02cb9c0:       stw     r28,64(r1)
     0.00 :	  c02cb9c4:       stw     r29,68(r1)
     0.00 :	  c02cb9c8:       bl      c071db48 <__stack_chk_fail>
     0.00 :	  c02cb9cc:       cmpwi   r29,0
     0.00 :	  c02cb9d0:       bne     c02cb9fc <iov_iter_zero+0x658>
     0.00 :	  c02cb9d4:       lwz     r9,8(r30)
     0.00 :	  c02cb9d8:       lwz     r0,84(r1)
     0.00 :	  c02cb9dc:       lwz     r7,12(r28)
     0.00 :	  c02cb9e0:       subf    r9,r27,r9
     0.00 :	  c02cb9e4:       mr      r28,r26
     0.00 :	  c02cb9e8:       lwz     r10,12(r30)
     0.00 :	  c02cb9ec:       lwz     r25,52(r1)
     0.00 :	  c02cb9f0:       mtlr    r0
     0.00 :	  c02cb9f4:       lwz     r26,56(r1)
     0.00 :	  c02cb9f8:       b       c02cb498 <iov_iter_zero+0xf4>
     0.00 :	  c02cb9fc:       lwz     r0,84(r1)
     0.00 :	  c02cba00:       mtlr    r0
     0.00 :	  c02cba04:       mr      r28,r26
     0.00 :	  c02cba08:       b       c02cb8ec <iov_iter_zero+0x548>

Christophe
