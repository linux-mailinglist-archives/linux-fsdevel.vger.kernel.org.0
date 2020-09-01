Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7D259EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgIATCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 15:02:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28799 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIATCf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:02:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BgxJ45VTfz9tynm;
        Tue,  1 Sep 2020 21:01:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 30UTQYtQzNHs; Tue,  1 Sep 2020 21:01:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BgxJ44W4jz9ty6y;
        Tue,  1 Sep 2020 21:01:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FF048B7F6;
        Tue,  1 Sep 2020 21:01:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rKWWAH3ZSGeO; Tue,  1 Sep 2020 21:01:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 106768B7F5;
        Tue,  1 Sep 2020 21:01:39 +0200 (CEST)
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
Message-ID: <80f82498-086d-7b31-690c-cece6c37f519@csgroup.eu>
Date:   Tue, 1 Sep 2020 21:01:24 +0200
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

As a comparison, hereunder is the perf annotate of the 5.9-rc2 without 
the series:

  Percent |	Source code & Disassembly of vmlinux for cpu-clock (2581 
samples)
---------------------------------------------------------------------------------
          :
          :
          :
          :	Disassembly of section .text:
          :
          :	c02cbb80 <iov_iter_zero>:
          :	iov_iter_zero():
     3.22 :	  c02cbb80:       stwu    r1,-80(r1)
     3.25 :	  c02cbb84:       stw     r30,72(r1)
     0.00 :	  c02cbb88:       mr      r30,r4
     2.91 :	  c02cbb8c:       stw     r31,76(r1)
     0.00 :	  c02cbb90:       mr      r31,r3
     0.19 :	  c02cbb94:       stw     r27,60(r1)
          :	iov_iter_type():
     1.82 :	  c02cbb98:       lwz     r10,0(r4)
     0.54 :	  c02cbb9c:       rlwinm  r9,r10,0,0,30
          :	iov_iter_zero():
     1.98 :	  c02cbba0:       cmpwi   r9,32
     0.00 :	  c02cbba4:       lwz     r9,624(r2)
     0.35 :	  c02cbba8:       stw     r9,28(r1)
     0.00 :	  c02cbbac:       li      r9,0
     0.00 :	  c02cbbb0:       beq     c02cbd00 <iov_iter_zero+0x180>
     2.67 :	  c02cbbb4:       lwz     r9,8(r4)
     1.98 :	  c02cbbb8:       cmplw   r9,r3
     0.00 :	  c02cbbbc:       mr      r27,r9
     0.00 :	  c02cbbc0:       bgt     c02cbce8 <iov_iter_zero+0x168>
     0.31 :	  c02cbbc4:       cmpwi   r9,0
     0.00 :	  c02cbbc8:       beq     c02cbcbc <iov_iter_zero+0x13c>
     3.22 :	  c02cbbcc:       andi.   r8,r10,16
     1.70 :	  c02cbbd0:       lwz     r31,4(r30)
     0.00 :	  c02cbbd4:       bne     c02cbe10 <iov_iter_zero+0x290>
     0.31 :	  c02cbbd8:       andi.   r8,r10,8
     0.00 :	  c02cbbdc:       bne     c02cbf64 <iov_iter_zero+0x3e4>
     1.82 :	  c02cbbe0:       andi.   r10,r10,64
     0.00 :	  c02cbbe4:       bne     c02cc080 <iov_iter_zero+0x500>
     0.27 :	  c02cbbe8:       stw     r29,68(r1)
     1.94 :	  c02cbbec:       stw     r28,64(r1)
     1.98 :	  c02cbbf0:       lwz     r28,12(r30)
     0.31 :	  c02cbbf4:       lwz     r7,4(r28)
     2.13 :	  c02cbbf8:       subf    r29,r31,r7
     1.78 :	  c02cbbfc:       cmplw   r29,r27
     0.08 :	  c02cbc00:       bgt     c02cbcf8 <iov_iter_zero+0x178>
    28.24 :	  c02cbc04:       cmpwi   r29,0
     0.00 :	  c02cbc08:       beq     c02cc08c <iov_iter_zero+0x50c>
     2.01 :	  c02cbc0c:       lwz     r3,0(r28)
     3.10 :	  c02cbc10:       lwz     r10,1208(r2)
     0.00 :	  c02cbc14:       add     r3,r3,r31
          :	__access_ok():
     0.00 :	  c02cbc18:       cmplw   r3,r10
     0.00 :	  c02cbc1c:       bgt     c02cbc7c <iov_iter_zero+0xfc>
     3.37 :	  c02cbc20:       subf    r10,r3,r10
     0.00 :	  c02cbc24:       addi    r8,r29,-1
     3.14 :	  c02cbc28:       cmplw   r8,r10
     0.08 :	  c02cbc2c:       mflr    r0
     0.00 :	  c02cbc30:       stw     r0,84(r1)
     0.00 :	  c02cbc34:       bgt     c02cbd40 <iov_iter_zero+0x1c0>
          :	clear_user():
     0.00 :	  c02cbc38:       mr      r4,r29
     2.40 :	  c02cbc3c:       bl      c001a428 <__arch_clear_user>
          :	iov_iter_zero():
     1.55 :	  c02cbc40:       add     r31,r31,r29
     0.00 :	  c02cbc44:       cmpwi   r3,0
     1.94 :	  c02cbc48:       subf    r29,r29,r27
     0.00 :	  c02cbc4c:       subf    r31,r3,r31
     0.00 :	  c02cbc50:       add     r29,r29,r3
     0.00 :	  c02cbc54:       beq     c02cc0ac <iov_iter_zero+0x52c>
     0.00 :	  c02cbc58:       lwz     r9,8(r30)
     0.00 :	  c02cbc5c:       subf    r10,r27,r29
     0.00 :	  c02cbc60:       lwz     r0,84(r1)
     0.00 :	  c02cbc64:       subf    r27,r29,r27
     0.00 :	  c02cbc68:       add     r9,r10,r9
     0.00 :	  c02cbc6c:       lwz     r7,4(r28)
     0.00 :	  c02cbc70:       lwz     r10,12(r30)
     0.00 :	  c02cbc74:       mtlr    r0
     0.00 :	  c02cbc78:       b       c02cbc84 <iov_iter_zero+0x104>
          :	__access_ok():
     0.00 :	  c02cbc7c:       li      r27,0
     0.00 :	  c02cbc80:       mr      r10,r28
          :	iov_iter_zero():
     0.00 :	  c02cbc84:       cmplw   r31,r7
     0.00 :	  c02cbc88:       bne     c02cbc94 <iov_iter_zero+0x114>
     0.93 :	  c02cbc8c:       addi    r28,r28,8
     0.00 :	  c02cbc90:       li      r31,0
     1.28 :	  c02cbc94:       lwz     r8,16(r30)
     0.00 :	  c02cbc98:       subf    r10,r10,r28
     1.05 :	  c02cbc9c:       srawi   r10,r10,3
     0.00 :	  c02cbca0:       stw     r28,12(r30)
     0.00 :	  c02cbca4:       subf    r10,r10,r8
     0.93 :	  c02cbca8:       stw     r10,16(r30)
     0.04 :	  c02cbcac:       lwz     r28,64(r1)
     0.00 :	  c02cbcb0:       lwz     r29,68(r1)
     1.05 :	  c02cbcb4:       stw     r9,8(r30)
     0.00 :	  c02cbcb8:       stw     r31,4(r30)
     1.39 :	  c02cbcbc:       lwz     r9,28(r1)
     0.00 :	  c02cbcc0:       lwz     r10,624(r2)
     1.08 :	  c02cbcc4:       xor.    r9,r9,r10
     0.00 :	  c02cbcc8:       li      r10,0
     0.00 :	  c02cbccc:       bne     c02cc180 <iov_iter_zero+0x600>
     1.08 :	  c02cbcd0:       mr      r3,r27
     0.00 :	  c02cbcd4:       lwz     r30,72(r1)
     0.08 :	  c02cbcd8:       lwz     r27,60(r1)
     1.01 :	  c02cbcdc:       lwz     r31,76(r1)
     0.00 :	  c02cbce0:       addi    r1,r1,80
     0.04 :	  c02cbce4:       blr
     0.00 :	  c02cbce8:       cmpwi   r9,0
     0.00 :	  c02cbcec:       mr      r27,r3
     0.00 :	  c02cbcf0:       beq     c02cbcbc <iov_iter_zero+0x13c>
     0.00 :	  c02cbcf4:       b       c02cbbcc <iov_iter_zero+0x4c>
     0.00 :	  c02cbcf8:       mr      r29,r27
     0.00 :	  c02cbcfc:       b       c02cbc04 <iov_iter_zero+0x84>
          :	pipe_zero():
     0.00 :	  c02cbd00:       mflr    r0
     0.00 :	  c02cbd04:       stw     r26,56(r1)
     0.00 :	  c02cbd08:       stw     r0,84(r1)
     0.00 :	  c02cbd0c:       mr      r3,r4
     0.00 :	  c02cbd10:       stw     r28,64(r1)
     0.00 :	  c02cbd14:       lwz     r28,12(r4)
     0.00 :	  c02cbd18:       lwz     r26,40(r28)
     0.00 :	  c02cbd1c:       bl      c02c95d0 <sanity>
     0.00 :	  c02cbd20:       cmpwi   r3,0
     0.00 :	  c02cbd24:       bne     c02cbd54 <iov_iter_zero+0x1d4>
     0.00 :	  c02cbd28:       lwz     r0,84(r1)
     0.00 :	  c02cbd2c:       li      r27,0
     0.00 :	  c02cbd30:       lwz     r26,56(r1)
     0.00 :	  c02cbd34:       lwz     r28,64(r1)
     0.00 :	  c02cbd38:       mtlr    r0
     0.00 :	  c02cbd3c:       b       c02cbcbc <iov_iter_zero+0x13c>
          :	__access_ok():
     0.00 :	  c02cbd40:       lwz     r0,84(r1)
     0.00 :	  c02cbd44:       li      r27,0
     0.00 :	  c02cbd48:       mr      r10,r28
     0.00 :	  c02cbd4c:       mtlr    r0
     0.00 :	  c02cbd50:       b       c02cbc84 <iov_iter_zero+0x104>
          :	pipe_zero():
     0.00 :	  c02cbd54:       mr      r4,r31
     0.00 :	  c02cbd58:       addi    r6,r1,24
     0.00 :	  c02cbd5c:       addi    r5,r1,20
     0.00 :	  c02cbd60:       mr      r3,r30
     0.00 :	  c02cbd64:       bl      c02c97ac <push_pipe>
     0.00 :	  c02cbd68:       mr.     r27,r3
     0.00 :	  c02cbd6c:       beq     c02cbd28 <iov_iter_zero+0x1a8>
     0.00 :	  c02cbd70:       lwz     r4,24(r1)
     0.00 :	  c02cbd74:       addi    r26,r26,-1
     0.00 :	  c02cbd78:       lwz     r9,20(r1)
     0.00 :	  c02cbd7c:       stw     r25,52(r1)
     0.00 :	  c02cbd80:       li      r25,0
     0.00 :	  c02cbd84:       stw     r29,68(r1)
     0.00 :	  c02cbd88:       mr      r29,r27
     0.00 :	  c02cbd8c:       subfic  r31,r4,4096
     0.00 :	  c02cbd90:       cmplw   r31,r29
     0.00 :	  c02cbd94:       ble     c02cbd9c <iov_iter_zero+0x21c>
     0.00 :	  c02cbd98:       mr      r31,r29
     0.00 :	  c02cbd9c:       and     r9,r26,r9
     0.00 :	  c02cbda0:       lwz     r8,80(r28)
     0.00 :	  c02cbda4:       rlwinm  r10,r9,1,0,30
     0.00 :	  c02cbda8:       add     r9,r10,r9
     0.00 :	  c02cbdac:       rlwinm  r9,r9,3,0,28
     0.00 :	  c02cbdb0:       lwzx    r3,r8,r9
     0.00 :	  c02cbdb4:       mr      r5,r31
     0.00 :	  c02cbdb8:       bl      c02c99d0 <memzero_page>
     0.00 :	  c02cbdbc:       subf.   r29,r31,r29
     0.00 :	  c02cbdc0:       lwz     r9,20(r1)
     0.00 :	  c02cbdc4:       li      r4,0
     0.00 :	  c02cbdc8:       lwz     r10,24(r1)
     0.00 :	  c02cbdcc:       stw     r9,16(r30)
     0.00 :	  c02cbdd0:       addi    r9,r9,1
     0.00 :	  c02cbdd4:       add     r10,r10,r31
     0.00 :	  c02cbdd8:       stw     r9,20(r1)
     0.00 :	  c02cbddc:       stw     r10,4(r30)
     0.00 :	  c02cbde0:       stw     r25,24(r1)
     0.00 :	  c02cbde4:       bne     c02cbd8c <iov_iter_zero+0x20c>
     0.00 :	  c02cbde8:       lwz     r9,8(r30)
     0.00 :	  c02cbdec:       subf    r9,r27,r9
     0.00 :	  c02cbdf0:       stw     r9,8(r30)
          :	iov_iter_zero():
     0.00 :	  c02cbdf4:       lwz     r0,84(r1)
     0.00 :	  c02cbdf8:       lwz     r25,52(r1)
     0.00 :	  c02cbdfc:       lwz     r26,56(r1)
     0.00 :	  c02cbe00:       mtlr    r0
     0.00 :	  c02cbe04:       lwz     r28,64(r1)
     0.00 :	  c02cbe08:       lwz     r29,68(r1)
     0.00 :	  c02cbe0c:       b       c02cbcbc <iov_iter_zero+0x13c>
     0.00 :	  c02cbe10:       stw     r23,44(r1)
     0.00 :	  c02cbe14:       cmpwi   r27,0
     0.00 :	  c02cbe18:       stw     r28,64(r1)
     0.00 :	  c02cbe1c:       mr      r23,r27
     0.00 :	  c02cbe20:       stw     r24,48(r1)
     0.00 :	  c02cbe24:       li      r28,0
     0.00 :	  c02cbe28:       lwz     r24,12(r30)
     0.00 :	  c02cbe2c:       mr      r8,r24
     0.00 :	  c02cbe30:       beq     c02cbf08 <iov_iter_zero+0x388>
     0.00 :	  c02cbe34:       mflr    r0
     0.00 :	  c02cbe38:       stw     r25,52(r1)
     0.00 :	  c02cbe3c:       stw     r0,84(r1)
     0.00 :	  c02cbe40:       stw     r26,56(r1)
     0.00 :	  c02cbe44:       stw     r29,68(r1)
     0.00 :	  c02cbe48:       rlwinm  r25,r28,1,0,30
     0.00 :	  c02cbe4c:       add     r25,r25,r28
     0.00 :	  c02cbe50:       rlwinm  r25,r25,2,0,29
     0.00 :	  c02cbe54:       add     r10,r8,r25
     0.00 :	  c02cbe58:       lwz     r26,4(r10)
     0.00 :	  c02cbe5c:       mr      r29,r25
     0.00 :	  c02cbe60:       lwz     r9,8(r10)
     0.00 :	  c02cbe64:       subf    r26,r31,r26
     0.00 :	  c02cbe68:       cmplw   r26,r23
     0.00 :	  c02cbe6c:       add     r9,r31,r9
     0.00 :	  c02cbe70:       clrlwi  r4,r9,20
     0.00 :	  c02cbe74:       ble     c02cbe7c <iov_iter_zero+0x2fc>
     0.00 :	  c02cbe78:       mr      r26,r23
     0.00 :	  c02cbe7c:       subfic  r7,r4,4096
     0.00 :	  c02cbe80:       cmplw   r26,r7
     0.00 :	  c02cbe84:       ble     c02cbe8c <iov_iter_zero+0x30c>
     0.00 :	  c02cbe88:       mr      r26,r7
     0.00 :	  c02cbe8c:       cmpwi   r26,0
     0.00 :	  c02cbe90:       beq     c02cbeb4 <iov_iter_zero+0x334>
     0.00 :	  c02cbe94:       lwz     r3,0(r10)
     0.00 :	  c02cbe98:       rlwinm  r9,r9,25,7,26
     0.00 :	  c02cbe9c:       mr      r5,r26
     0.00 :	  c02cbea0:       add     r3,r3,r9
     0.00 :	  c02cbea4:       bl      c02c99d0 <memzero_page>
          :	bvec_iter_advance():
     0.00 :	  c02cbea8:       cmplw   r23,r26
          :	iov_iter_zero():
     0.00 :	  c02cbeac:       lwz     r8,12(r30)
          :	bvec_iter_advance():
     0.00 :	  c02cbeb0:       blt     c02cc044 <iov_iter_zero+0x4c4>
     0.00 :	  c02cbeb4:       add.    r31,r31,r26
     0.00 :	  c02cbeb8:       subf    r23,r26,r23
     0.00 :	  c02cbebc:       addi    r10,r8,4
     0.00 :	  c02cbec0:       bne     c02cbed8 <iov_iter_zero+0x358>
     0.00 :	  c02cbec4:       b       c02cbee4 <iov_iter_zero+0x364>
     0.00 :	  c02cbec8:       subf.   r31,r9,r31
     0.00 :	  c02cbecc:       addi    r28,r28,1
     0.00 :	  c02cbed0:       addi    r29,r29,12
     0.00 :	  c02cbed4:       beq     c02cbf54 <iov_iter_zero+0x3d4>
     0.00 :	  c02cbed8:       lwzx    r9,r10,r29
     0.00 :	  c02cbedc:       cmplw   r31,r9
     0.00 :	  c02cbee0:       bge     c02cbec8 <iov_iter_zero+0x348>
          :	iov_iter_zero():
     0.00 :	  c02cbee4:       cmpwi   r23,0
     0.00 :	  c02cbee8:       bne     c02cbe48 <iov_iter_zero+0x2c8>
     0.00 :	  c02cbeec:       add     r8,r8,r29
     0.00 :	  c02cbef0:       lwz     r0,84(r1)
     0.00 :	  c02cbef4:       lwz     r9,8(r30)
     0.00 :	  c02cbef8:       lwz     r25,52(r1)
     0.00 :	  c02cbefc:       mtlr    r0
     0.00 :	  c02cbf00:       lwz     r26,56(r1)
     0.00 :	  c02cbf04:       lwz     r29,68(r1)
     0.00 :	  c02cbf08:       subf    r24,r24,r8
     0.00 :	  c02cbf0c:       stw     r8,12(r30)
     0.00 :	  c02cbf10:       srawi   r6,r24,2
     0.00 :	  c02cbf14:       lwz     r7,16(r30)
     0.00 :	  c02cbf18:       rlwinm  r10,r24,0,0,29
     0.00 :	  c02cbf1c:       add     r10,r10,r6
     0.00 :	  c02cbf20:       rlwinm  r8,r10,4,0,27
     0.00 :	  c02cbf24:       add     r10,r10,r8
     0.00 :	  c02cbf28:       rlwinm  r8,r10,8,0,23
     0.00 :	  c02cbf2c:       add     r10,r10,r8
     0.00 :	  c02cbf30:       rlwinm  r8,r10,16,0,15
     0.00 :	  c02cbf34:       add     r10,r10,r8
     0.00 :	  c02cbf38:       add     r10,r7,r10
     0.00 :	  c02cbf3c:       stw     r10,16(r30)
     0.00 :	  c02cbf40:       subf    r9,r27,r9
     0.00 :	  c02cbf44:       lwz     r23,44(r1)
     0.00 :	  c02cbf48:       lwz     r24,48(r1)
     0.00 :	  c02cbf4c:       lwz     r28,64(r1)
     0.00 :	  c02cbf50:       b       c02cbcb4 <iov_iter_zero+0x134>
     0.00 :	  c02cbf54:       rlwinm  r29,r28,1,0,30
     0.00 :	  c02cbf58:       add     r29,r29,r28
     0.00 :	  c02cbf5c:       rlwinm  r29,r29,2,0,29
     0.00 :	  c02cbf60:       b       c02cbee4 <iov_iter_zero+0x364>
     0.00 :	  c02cbf64:       mflr    r0
     0.00 :	  c02cbf68:       stw     r26,56(r1)
     0.00 :	  c02cbf6c:       stw     r0,84(r1)
     0.00 :	  c02cbf70:       stw     r28,64(r1)
     0.00 :	  c02cbf74:       stw     r29,68(r1)
     0.00 :	  c02cbf78:       lwz     r28,12(r30)
     0.00 :	  c02cbf7c:       lwz     r29,4(r28)
     0.00 :	  c02cbf80:       subf    r29,r31,r29
     0.00 :	  c02cbf84:       cmplw   r29,r27
     0.00 :	  c02cbf88:       ble     c02cbf90 <iov_iter_zero+0x410>
     0.00 :	  c02cbf8c:       mr      r29,r27
     0.00 :	  c02cbf90:       cmpwi   r29,0
     0.00 :	  c02cbf94:       beq     c02cc0b8 <iov_iter_zero+0x538>
     0.00 :	  c02cbf98:       lwz     r3,0(r28)
     0.00 :	  c02cbf9c:       mr      r5,r29
     0.00 :	  c02cbfa0:       li      r4,0
     0.00 :	  c02cbfa4:       add     r3,r3,r31
     0.00 :	  c02cbfa8:       subf    r26,r29,r27
     0.00 :	  c02cbfac:       bl      c001999c <memset>
     0.00 :	  c02cbfb0:       add     r31,r31,r29
     0.00 :	  c02cbfb4:       cmpwi   r26,0
     0.00 :	  c02cbfb8:       bne     c02cc00c <iov_iter_zero+0x48c>
     0.00 :	  c02cbfbc:       lwz     r9,4(r28)
     0.00 :	  c02cbfc0:       cmpw    r9,r31
     0.00 :	  c02cbfc4:       bne     c02cbfd0 <iov_iter_zero+0x450>
     0.00 :	  c02cbfc8:       addi    r28,r28,8
     0.00 :	  c02cbfcc:       li      r31,0
     0.00 :	  c02cbfd0:       lwz     r9,12(r30)
     0.00 :	  c02cbfd4:       lwz     r8,16(r30)
     0.00 :	  c02cbfd8:       subf    r10,r9,r28
     0.00 :	  c02cbfdc:       stw     r28,12(r30)
     0.00 :	  c02cbfe0:       srawi   r10,r10,3
     0.00 :	  c02cbfe4:       lwz     r9,8(r30)
     0.00 :	  c02cbfe8:       subf    r10,r10,r8
     0.00 :	  c02cbfec:       stw     r10,16(r30)
     0.00 :	  c02cbff0:       subf    r9,r27,r9
     0.00 :	  c02cbff4:       lwz     r0,84(r1)
     0.00 :	  c02cbff8:       lwz     r26,56(r1)
     0.00 :	  c02cbffc:       lwz     r28,64(r1)
     0.00 :	  c02cc000:       mtlr    r0
     0.00 :	  c02cc004:       lwz     r29,68(r1)
     0.00 :	  c02cc008:       b       c02cbcb4 <iov_iter_zero+0x134>
     0.00 :	  c02cc00c:       lwz     r31,12(r28)
     0.00 :	  c02cc010:       addi    r28,r28,8
     0.00 :	  c02cc014:       cmplw   r31,r26
     0.00 :	  c02cc018:       ble     c02cc020 <iov_iter_zero+0x4a0>
     0.00 :	  c02cc01c:       mr      r31,r26
     0.00 :	  c02cc020:       cmpwi   r31,0
     0.00 :	  c02cc024:       beq     c02cc00c <iov_iter_zero+0x48c>
     0.00 :	  c02cc028:       lwz     r3,0(r28)
     0.00 :	  c02cc02c:       mr      r5,r31
     0.00 :	  c02cc030:       li      r4,0
     0.00 :	  c02cc034:       bl      c001999c <memset>
     0.00 :	  c02cc038:       subf.   r26,r31,r26
     0.00 :	  c02cc03c:       beq     c02cbfbc <iov_iter_zero+0x43c>
     0.00 :	  c02cc040:       b       c02cc00c <iov_iter_zero+0x48c>
          :	bvec_iter_advance():
     0.00 :	  c02cc044:       lis     r9,-16236
     0.00 :	  c02cc048:       lbz     r10,-20202(r9)
     0.00 :	  c02cc04c:       cmpwi   r10,0
     0.00 :	  c02cc050:       beq     c02cc05c <iov_iter_zero+0x4dc>
          :	iov_iter_zero():
     0.00 :	  c02cc054:       add     r8,r8,r25
     0.00 :	  c02cc058:       b       c02cbef0 <iov_iter_zero+0x370>
          :	bvec_iter_advance():
     0.00 :	  c02cc05c:       lis     r3,-16253
     0.00 :	  c02cc060:       li      r10,1
     0.00 :	  c02cc064:       addi    r3,r3,7692
     0.00 :	  c02cc068:       stb     r10,-20202(r9)
     0.00 :	  c02cc06c:       bl      c0029bc0 <__warn_printk>
     0.00 :	  c02cc070:       twui    r0,0
          :	iov_iter_zero():
     0.00 :	  c02cc074:       lwz     r8,12(r30)
     0.00 :	  c02cc078:       add     r8,r8,r25
     0.00 :	  c02cc07c:       b       c02cbef0 <iov_iter_zero+0x370>
     0.00 :	  c02cc080:       add     r31,r31,r27
     0.00 :	  c02cc084:       subf    r9,r27,r9
     0.00 :	  c02cc088:       b       c02cbcb4 <iov_iter_zero+0x134>
     0.00 :	  c02cc08c:       mr      r29,r27
     0.00 :	  c02cc090:       cmpwi   r29,0
     0.00 :	  c02cc094:       bne     c02cc0c0 <iov_iter_zero+0x540>
     1.51 :	  c02cc098:       lwz     r9,8(r30)
     0.00 :	  c02cc09c:       lwz     r7,4(r28)
     0.00 :	  c02cc0a0:       lwz     r10,12(r30)
     0.00 :	  c02cc0a4:       subf    r9,r27,r9
     0.00 :	  c02cc0a8:       b       c02cbc84 <iov_iter_zero+0x104>
     1.47 :	  c02cc0ac:       lwz     r0,84(r1)
     6.47 :	  c02cc0b0:       mtlr    r0
     0.00 :	  c02cc0b4:       b       c02cc090 <iov_iter_zero+0x510>
     0.00 :	  c02cc0b8:       mr      r26,r27
     0.00 :	  c02cc0bc:       b       c02cbfb4 <iov_iter_zero+0x434>
     0.00 :	  c02cc0c0:       stw     r26,56(r1)
     0.00 :	  c02cc0c4:       lwz     r7,12(r28)
     0.00 :	  c02cc0c8:       addi    r26,r28,8
     0.00 :	  c02cc0cc:       mr      r31,r29
     0.00 :	  c02cc0d0:       cmplw   r29,r7
     0.00 :	  c02cc0d4:       ble     c02cc0dc <iov_iter_zero+0x55c>
     0.00 :	  c02cc0d8:       mr      r31,r7
     0.00 :	  c02cc0dc:       cmpwi   r31,0
     0.00 :	  c02cc0e0:       beq     c02cc1d8 <iov_iter_zero+0x658>
     0.00 :	  c02cc0e4:       lwz     r3,0(r26)
          :	clear_user():
     0.00 :	  c02cc0e8:       lwz     r9,1208(r2)
          :	__access_ok():
     0.00 :	  c02cc0ec:       cmplw   r3,r9
     0.00 :	  c02cc0f0:       bgt     c02cc114 <iov_iter_zero+0x594>
     0.00 :	  c02cc0f4:       subf    r9,r3,r9
     0.00 :	  c02cc0f8:       addi    r10,r31,-1
     0.00 :	  c02cc0fc:       cmplw   r10,r9
     0.00 :	  c02cc100:       mflr    r0
     0.00 :	  c02cc104:       stw     r0,84(r1)
     0.00 :	  c02cc108:       ble     c02cc138 <iov_iter_zero+0x5b8>
     0.00 :	  c02cc10c:       lwz     r0,84(r1)
     0.00 :	  c02cc110:       mtlr    r0
          :	iov_iter_zero():
     0.00 :	  c02cc114:       lwz     r9,8(r30)
     0.00 :	  c02cc118:       subf    r8,r27,r29
     0.00 :	  c02cc11c:       mr      r28,r26
     0.00 :	  c02cc120:       lwz     r10,12(r30)
     0.00 :	  c02cc124:       lwz     r26,56(r1)
     0.00 :	  c02cc128:       add     r9,r8,r9
     0.00 :	  c02cc12c:       subf    r27,r29,r27
     0.00 :	  c02cc130:       li      r31,0
     0.00 :	  c02cc134:       b       c02cbc84 <iov_iter_zero+0x104>
          :	clear_user():
     0.00 :	  c02cc138:       mr      r4,r31
     0.00 :	  c02cc13c:       bl      c001a428 <__arch_clear_user>
          :	iov_iter_zero():
     0.00 :	  c02cc140:       subf    r29,r31,r29
     0.00 :	  c02cc144:       cmpwi   r3,0
     0.00 :	  c02cc148:       subf    r31,r3,r31
     0.00 :	  c02cc14c:       add     r29,r3,r29
     0.00 :	  c02cc150:       beq     c02cc1a4 <iov_iter_zero+0x624>
     0.00 :	  c02cc154:       lwz     r9,8(r30)
     0.00 :	  c02cc158:       subf    r8,r27,r29
     0.00 :	  c02cc15c:       lwz     r0,84(r1)
     0.00 :	  c02cc160:       subf    r27,r29,r27
     0.00 :	  c02cc164:       lwz     r7,12(r28)
     0.00 :	  c02cc168:       add     r9,r8,r9
     0.00 :	  c02cc16c:       mr      r28,r26
     0.00 :	  c02cc170:       lwz     r10,12(r30)
     0.00 :	  c02cc174:       lwz     r26,56(r1)
     0.00 :	  c02cc178:       mtlr    r0
     0.00 :	  c02cc17c:       b       c02cbc84 <iov_iter_zero+0x104>
     0.00 :	  c02cc180:       mflr    r0
     0.00 :	  c02cc184:       stw     r23,44(r1)
     0.00 :	  c02cc188:       stw     r0,84(r1)
     0.00 :	  c02cc18c:       stw     r24,48(r1)
     0.00 :	  c02cc190:       stw     r25,52(r1)
     0.00 :	  c02cc194:       stw     r26,56(r1)
     0.00 :	  c02cc198:       stw     r28,64(r1)
     0.00 :	  c02cc19c:       stw     r29,68(r1)
     0.00 :	  c02cc1a0:       bl      c071e2b0 <__stack_chk_fail>
     0.00 :	  c02cc1a4:       cmpwi   r29,0
     0.00 :	  c02cc1a8:       bne     c02cc1d0 <iov_iter_zero+0x650>
     0.00 :	  c02cc1ac:       lwz     r9,8(r30)
     0.00 :	  c02cc1b0:       lwz     r0,84(r1)
     0.00 :	  c02cc1b4:       lwz     r7,12(r28)
     0.00 :	  c02cc1b8:       subf    r9,r27,r9
     0.00 :	  c02cc1bc:       mr      r28,r26
     0.00 :	  c02cc1c0:       lwz     r10,12(r30)
     0.00 :	  c02cc1c4:       lwz     r26,56(r1)
     0.00 :	  c02cc1c8:       mtlr    r0
     0.00 :	  c02cc1cc:       b       c02cbc84 <iov_iter_zero+0x104>
     0.00 :	  c02cc1d0:       lwz     r0,84(r1)
     0.00 :	  c02cc1d4:       mtlr    r0
     0.00 :	  c02cc1d8:       mr      r28,r26
     0.00 :	  c02cc1dc:       b       c02cc0c4 <iov_iter_zero+0x544>


Christophe
