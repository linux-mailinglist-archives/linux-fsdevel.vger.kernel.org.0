Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87ACD9E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 02:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfJGAXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 20:23:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36059 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGAXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:23:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so7532821pfr.3;
        Sun, 06 Oct 2019 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RwMl+kzFOZSl0V3/q1MSQxsTBLYET/w5hSlcQasH80o=;
        b=C8EgUvD90pXyuuhdAiWuMHH7EbmUUQHwvlTU2IeOkDm6Zfh9NhKxEztRs5OFozZ5Nu
         AeyohD2YBPphTsE7eIbj8l/Do3PzdISt+mrWJJiFj8KHEbt59WyYaic8DCo3RY75Z7Rh
         eUCIpQMD6P6pQpO76sKuGSBqC7xb8pOzH7W4C5pfW+ruWOmp/6W7z/nuFDYFZHa9U2bE
         4LNBt4qoZoEAC50bjWNZGSRF6piSf+fIMx6vRt0zaERNbZ0/SXXNfhqLdRw0HC9QfpEL
         F0tU55n31I1vsYF4eiY/F0HWhRfvT8uc1jG5Al4NMvw0Ajew1Ab05ZDX7vplx+mpDTnB
         s38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RwMl+kzFOZSl0V3/q1MSQxsTBLYET/w5hSlcQasH80o=;
        b=Byf+Fs1nVrL8RZSJTMG9U3/V6kDTm6McLvX+/pxJ5YS5yMOEm8WZ2ik6+scpHMKc7/
         Ysn1nZD1EeYZiqOp+pUfCru0TcrdL1QfIYZv2ZIogqY7B/bsY6w8CyM2E6ggZx71XJpP
         imVFoxyB+uFdXafKBE2u3cWjWpg7QfsPzM9D7WqP1t4afEFACbYMQZTimlwdOdB+SUCY
         nc9P0APE7R0CQLiXLNzEsvzCmQpH8DWeUIVf34QjWaWNT6eCJFbR+4G6wOO0ro4fnnoW
         ZIJykfjmnJ6XLMXcQddnR6TlZMjseJAfi5w3lbOIi4ssPJxPyLjc1qSbeg3fj7qF5Pg+
         tZ9w==
X-Gm-Message-State: APjAAAWT4lEmyxwR5dqwB2OIYYbnpayEom2q40ARGyGOkJuByOAvWa6s
        UMLLqZx1pWe5Ug7FlY10roc=
X-Google-Smtp-Source: APXvYqzT01saB060XuiXRIQLDrnefNu+pRj2lRvBxta9P044EPaqmeOlVOQBknmvyTbl2Idg4VX4RA==
X-Received: by 2002:a63:1608:: with SMTP id w8mr27944378pgl.223.1570407801530;
        Sun, 06 Oct 2019 17:23:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm11318475pfo.105.2019.10.06.17.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 17:23:17 -0700 (PDT)
Date:   Sun, 6 Oct 2019 17:23:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
Message-ID: <20191007002316.GA30301@roeck-us.net>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 06, 2019 at 04:06:16PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > this patch causes all my sparc64 emulations to stall during boot. It causes
> > all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> > disk, and one of the xtensa emulations to crash with [2].
> 
> Ho humm. I've run variations of that patch over a few years on x86,
> but obviously not on alpha/sparc.
> 
> At least I should still be able to read alpha assembly, even after all
> these years. Would you mind sending me the result of
> 
>     make fs/readdir.s
> 
> on alpha with the broken config? I'd hope that the sparc issue is the same.
> 
> Actually, could you also do
> 
>     make fs/readdir.o
> 
> and then send me the "objdump --disassemble" of that? That way I get
> the instruction offsets without having to count by hand.
> 

Both attached for alpha.

> > Unable to handle kernel paging request at virtual address 0000000000000004
> > rcS(47): Oops -1
> > pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Not tainted
> > pc is at 0x4
> 
> That is _funky_. I'm not seeing how it could possibly jump to 0x4, but
> it clearly does.
> 
> That said, are you sure it's _that_ commit? Because this pattern:
> 
Bisect on sparc pointed to this commit, and re-running the tests with
the commit reverted passed for all architectures. I didn't check any
further.

Please let me know if you need anything else at this point.

Thanks,
Guenter

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="readdir.s"

	.set noreorder
	.set volatile
	.set noat
	.set nomacro
	.arch ev5
 # GNU C89 (GCC) version 9.2.0 (alpha-linux)
 #	compiled by GNU C version 6.5.0 20181026, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version none
 # warning: GMP header version 6.1.0 differs from library version 6.1.2.
 # warning: MPC header version 1.0.3 differs from library version 1.1.0.
 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed:  -nostdinc -I ./arch/alpha/include
 # -I ./arch/alpha/include/generated -I ./include
 # -I ./arch/alpha/include/uapi -I ./arch/alpha/include/generated/uapi
 # -I ./include/uapi -I ./include/generated/uapi
 # -iprefix /opt/kernel/gcc-9.2.0-nolibc/alpha-linux/bin/../lib/gcc/alpha-linux/9.2.0/
 # -D __KERNEL__ -D KBUILD_BASENAME="readdir" -D KBUILD_MODNAME="readdir"
 # -isystem /opt/kernel/gcc-9.2.0-nolibc/alpha-linux/bin/../lib/gcc/alpha-linux/9.2.0/include
 # -include ./include/linux/kconfig.h
 # -include ./include/linux/compiler_types.h -MD fs/.readdir.s.d
 # fs/readdir.c -mno-fp-regs -mcpu=ev5 -auxbase-strip fs/readdir.s -O2
 # -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs
 # -Werror=implicit-function-declaration -Werror=implicit-int
 # -Wno-format-security -Wno-frame-address -Wformat-truncation=0
 # -Wformat-overflow=0 -Wno-address-of-packed-member
 # -Wframe-larger-than=2048 -Wno-unused-but-set-variable
 # -Wimplicit-fallthrough=3 -Wunused-const-variable=0
 # -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
 # -Wno-stringop-truncation -Werror=date-time
 # -Werror=incompatible-pointer-types -Werror=designated-init
 # -Wno-packed-not-aligned -std=gnu90 -fno-strict-aliasing -fno-common
 # -fshort-wchar -fno-PIE -ffixed-8 -fno-jump-tables
 # -fno-delete-null-pointer-checks -fno-stack-protector
 # -fomit-frame-pointer -fno-strict-overflow -fno-merge-all-constants
 # -fmerge-constants -fstack-check=no -fconserve-stack
 # -fmacro-prefix-map=./= -fverbose-asm --param allow-store-data-races=0
 # options enabled:  -faggressive-loop-optimizations -falign-functions
 # -falign-jumps -falign-labels -falign-loops -fassume-phsa -fauto-inc-dec
 # -fbranch-count-reg -fcaller-saves -fcode-hoisting
 # -fcombine-stack-adjustments -fcompare-elim -fcprop-registers
 # -fcrossjumping -fcse-follow-jumps -fdefer-pop -fdevirtualize
 # -fdevirtualize-speculatively -fdwarf2-cfi-asm -fearly-inlining
 # -feliminate-unused-debug-types -fexpensive-optimizations
 # -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse
 # -fgcse-lm -fgnu-runtime -fgnu-unique -fguess-branch-probability
 # -fhoist-adjacent-loads -fident -fif-conversion -fif-conversion2
 # -findirect-inlining -finline -finline-atomics
 # -finline-functions-called-once -finline-small-functions -fipa-bit-cp
 # -fipa-cp -fipa-icf -fipa-icf-functions -fipa-icf-variables -fipa-profile
 # -fipa-pure-const -fipa-ra -fipa-reference -fipa-reference-addressable
 # -fipa-sra -fipa-stack-alignment -fipa-vrp -fira-hoist-pressure
 # -fira-share-save-slots -fira-share-spill-slots
 # -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
 # -fleading-underscore -flifetime-dse -flra-remat -flto-odr-type-merging
 # -fmath-errno -fmerge-constants -fmerge-debug-strings
 # -fmove-loop-invariants -fomit-frame-pointer -foptimize-sibling-calls
 # -foptimize-strlen -fpartial-inlining -fpcc-struct-return -fpeephole
 # -fpeephole2 -fplt -fprefetch-loop-arrays -free -freorder-blocks
 # -freorder-functions -frerun-cse-after-loop
 # -fsched-critical-path-heuristic -fsched-dep-count-heuristic
 # -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
 # -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
 # -fsched-stalled-insns-dep -fschedule-fusion -fschedule-insns
 # -fschedule-insns2 -fsemantic-interposition -fshow-column -fshrink-wrap
 # -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
 # -fsplit-wide-types -fssa-backprop -fssa-phiopt -fstdarg-opt
 # -fstore-merging -fstrict-volatile-bitfields -fsync-libcalls
 # -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
 # -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
 # -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
 # -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-if-convert
 # -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
 # -ftree-parallelize-loops= -ftree-phiprop -ftree-pre -ftree-pta
 # -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-slsr -ftree-sra
 # -ftree-switch-conversion -ftree-tail-merge -ftree-ter -ftree-vrp
 # -funit-at-a-time -funwind-tables -fverbose-asm -fwrapv -fwrapv-pointer
 # -fzero-initialized-in-bss -mexplicit-relocs -mfloat-ieee -mglibc
 # -mlarge-data -mlarge-text -mlong-double-64 -msoft-float

	.text
	.align 2
	.align 4
	.globl iterate_dir
	.ent iterate_dir
iterate_dir:
	.frame $30,64,$26,0
	.mask 0x400fe00,-64
$LFB3537:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!1	 #,,
	lda $29,0($29)		!gpdisp!1	 #,,
$iterate_dir..ng:
	lda $30,-64($30)	 #,,
	.cfi_def_cfa_offset 64
	bis $31,$31,$31
	stq $9,8($30)	 #,
	.cfi_offset 9, -56
	mov $16,$9	 # tmp144, file
	stq $11,24($30)	 #,
	.cfi_offset 11, -40
	mov $17,$11	 # tmp145, ctx
	stq $26,0($30)	 #,
	stq $10,16($30)	 #,
	stq $12,32($30)	 #,
	stq $13,40($30)	 #,
	stq $14,48($30)	 #,
	stq $15,56($30)	 #,
	.cfi_offset 26, -64
	.cfi_offset 10, -48
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	.cfi_offset 15, -8
	.prologue 1
 # fs/readdir.c:85: 	if (file->f_op->iterate_shared)
	ldq $1,40($16)	 # file_23(D)->f_op, _1
 # ./include/linux/fs.h:1318: 	return f->f_inode;
	ldq $12,32($16)	 # MEM[(const struct file *)file_23(D)].f_inode, _26
 # fs/readdir.c:85: 	if (file->f_op->iterate_shared)
	ldq $2,64($1)	 # _1->iterate_shared, _1->iterate_shared
	beq $2,$L20	 #, _1->iterate_shared,
 # fs/readdir.c:95: 		res = down_read_killable(&inode->i_rwsem);
	lda $13,160($12)	 # pretmp_38,, _26
	ldq $27,down_read_killable($29)		!literal!14	 #,,,
	mov $13,$16	 # pretmp_38,
 # fs/readdir.c:86: 		shared = true;
	lda $14,1($31)	 # shared,
 # fs/readdir.c:95: 		res = down_read_killable(&inode->i_rwsem);
	jsr $26,($27),down_read_killable		!lituse_jsr!14	 #,,
	ldah $29,0($26)		!gpdisp!15	 #
	lda $29,0($29)		!gpdisp!15	 #,,
	mov $0,$10	 # tmp146, <retval>
$L5:
 # fs/readdir.c:98: 	if (res)
	ldq_u $31,0($30)
	bne $10,$L3	 #, <retval>,
 # fs/readdir.c:102: 	if (!IS_DEADDIR(inode)) {
	ldl $1,12($12)	 #, _26->i_flags
 # fs/readdir.c:101: 	res = -ENOENT;
	lda $10,-2($31)	 # <retval>,
 # fs/readdir.c:102: 	if (!IS_DEADDIR(inode)) {
	and $1,16,$1	 # _26->i_flags,, tmp112
	bne $1,$L6	 #, tmp112,
 # fs/readdir.c:103: 		ctx->pos = file->f_pos;
	ldq $1,152($9)	 # file_23(D)->f_pos, _8
 # fs/readdir.c:105: 			res = file->f_op->iterate_shared(file, ctx);
	mov $11,$17	 # ctx,
	mov $9,$16	 # file,
 # fs/readdir.c:103: 		ctx->pos = file->f_pos;
	stq $1,8($11)	 # ctx_31(D)->pos, _8
 # fs/readdir.c:105: 			res = file->f_op->iterate_shared(file, ctx);
	ldq $1,40($9)	 # file_23(D)->f_op, file_23(D)->f_op
 # fs/readdir.c:104: 		if (shared)
	bne $14,$L21	 #, shared,
 # fs/readdir.c:107: 			res = file->f_op->iterate(file, ctx);
	ldq $27,56($1)	 # _11->iterate, _11->iterate
	jsr $26,($27),0	 # _11->iterate
	ldah $29,0($26)		!gpdisp!16
	lda $29,0($29)		!gpdisp!16
	mov $0,$10	 # tmp149, <retval>
	bis $31,$31,$31
$L8:
 # fs/readdir.c:108: 		file->f_pos = ctx->pos;
	ldq $1,8($11)	 # ctx_31(D)->pos, _13
 # ./include/linux/fs.h:1318: 	return f->f_inode;
	ldq $12,32($9)	 # MEM[(const struct file *)file_23(D)].f_inode, _47
 # ./include/linux/fsnotify.h:239: 	if (!(file->f_mode & FMODE_NONOTIFY))
	ldl $2,92($9)	 #, file_23(D)->f_mode
 # ./include/linux/fsnotify.h:237: 		mask |= FS_ISDIR;
	ldah $18,16384($31)	 # tmp100,
 # fs/readdir.c:108: 		file->f_pos = ctx->pos;
	stq $1,152($9)	 # file_23(D)->f_pos, _13
 # ./include/linux/fsnotify.h:237: 		mask |= FS_ISDIR;
	lda $18,1($18)	 # tmp143,, tmp100
 # ./include/linux/fsnotify.h:236: 	if (S_ISDIR(inode->i_mode))
	ldl $1,0($12)	 #,* _47
 # ./include/linux/fsnotify.h:237: 		mask |= FS_ISDIR;
	lda $11,1($31)	 # mask,
 # ./include/linux/fsnotify.h:239: 	if (!(file->f_mode & FMODE_NONOTIFY))
	srl $2,26,$2	 # file_23(D)->f_mode,, tmp131
 # ./include/linux/fsnotify.h:232: 	const struct path *path = &file->f_path;
	lda $15,16($9)	 # path,, file
 # ./include/linux/fsnotify.h:236: 	if (S_ISDIR(inode->i_mode))
	extwl $1,0,$3	 #, tmp122,, tmp121
	lda $1,-4096($31)	 # tmp124,
	and $1,$3,$1	 # tmp124, tmp121, tmp125
	lda $1,-16384($1)	 # tmp126,, tmp125
 # ./include/linux/fsnotify.h:237: 		mask |= FS_ISDIR;
	cmoveq $1,$18,$11	 #, tmp126, tmp143, mask
 # ./include/linux/fsnotify.h:239: 	if (!(file->f_mode & FMODE_NONOTIFY))
	blbc $2,$L22	 # tmp131,
$L11:
 # ./include/linux/fs.h:2201: 	if (!(file->f_flags & O_NOATIME))
	ldl $1,88($9)	 #, file_23(D)->f_flags
 # ./include/linux/fs.h:2201: 	if (!(file->f_flags & O_NOATIME))
	srl $1,20,$1	 # file_23(D)->f_flags,, tmp139
	ldq_u $31,0($30)
	blbs $1,$L6	 # tmp139,
 # ./include/linux/fs.h:2202: 		touch_atime(&file->f_path);
	ldq $27,touch_atime($29)		!literal!6	 #,,,
	mov $15,$16	 # path,
	jsr $26,($27),touch_atime		!lituse_jsr!6	 #,,
	ldah $29,0($26)		!gpdisp!7	 #
	lda $29,0($29)		!gpdisp!7	 #,,
	.align 4
$L6:
 # ./include/linux/fs.h:806: 	up_read(&inode->i_rwsem);
	mov $13,$16	 # pretmp_38,
 # fs/readdir.c:112: 	if (shared)
	beq $14,$L13	 #, shared,
 # ./include/linux/fs.h:806: 	up_read(&inode->i_rwsem);
	ldq $27,up_read($29)		!literal!4	 #,,,
	jsr $26,($27),up_read		!lituse_jsr!4	 #,,
	ldah $29,0($26)		!gpdisp!5	 #
	lda $29,0($29)		!gpdisp!5	 #,,
$L3:
 # fs/readdir.c:118: }
	mov $10,$0	 # <retval>,
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	ldq $13,40($30)	 #,
	ldq $14,48($30)	 #,
	ldq $15,56($30)	 #,
	bis $31,$31,$31
	lda $30,64($30)	 #,,
	.cfi_remember_state
	.cfi_restore 15
	.cfi_restore 14
	.cfi_restore 13
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L13:
	.cfi_restore_state
 # ./include/linux/fs.h:796: 	up_write(&inode->i_rwsem);
	ldq $27,up_write($29)		!literal!2	 #,,,
	bis $31,$31,$31
	jsr $26,($27),up_write		!lituse_jsr!2	 #,,
	ldah $29,0($26)		!gpdisp!3	 #
	lda $29,0($29)		!gpdisp!3	 #,,
 # ./include/linux/fs.h:797: }
	br $31,$L3	 #
	.align 4
$L20:
 # fs/readdir.c:87: 	else if (!file->f_op->iterate)
	ldq $1,56($1)	 # _1->iterate, _1->iterate
 # fs/readdir.c:84: 	int res = -ENOTDIR;
	lda $10,-20($31)	 # <retval>,
 # fs/readdir.c:87: 	else if (!file->f_op->iterate)
	ldq_u $31,0($30)
	beq $1,$L3	 #, _1->iterate,
 # fs/readdir.c:97: 		res = down_write_killable(&inode->i_rwsem);
	lda $13,160($12)	 # pretmp_38,, _26
	ldq $27,down_write_killable($29)		!literal!12	 #,,,
	mov $13,$16	 # pretmp_38,
 # fs/readdir.c:83: 	bool shared = false;
	mov $31,$14	 #, shared
 # fs/readdir.c:97: 		res = down_write_killable(&inode->i_rwsem);
	jsr $26,($27),down_write_killable		!lituse_jsr!12	 #,,
	ldah $29,0($26)		!gpdisp!13	 #
	lda $29,0($29)		!gpdisp!13	 #,,
	mov $0,$10	 # tmp147, <retval>
	br $31,$L5	 #
	.align 4
$L21:
 # fs/readdir.c:105: 			res = file->f_op->iterate_shared(file, ctx);
	ldq $27,64($1)	 # _9->iterate_shared, _9->iterate_shared
	jsr $26,($27),0	 # _9->iterate_shared
	ldah $29,0($26)		!gpdisp!17
	lda $29,0($29)		!gpdisp!17
	mov $0,$10	 # tmp148, <retval>
	br $31,$L8	 #
	.align 4
$L22:
 # ./include/linux/fsnotify.h:40: 	return __fsnotify_parent(path, dentry, mask);
	ldq $17,24($9)	 # MEM[(const struct path *)file_23(D) + 16B].dentry,
	ldq $27,__fsnotify_parent($29)		!literal!10	 #,,,
	mov $11,$18	 # mask,
	mov $15,$16	 # path,
	jsr $26,($27),__fsnotify_parent		!lituse_jsr!10	 #,,
	ldah $29,0($26)		!gpdisp!11	 #
	lda $29,0($29)		!gpdisp!11	 #,,
 # ./include/linux/fsnotify.h:52: 	if (ret)
	bne $0,$L11	 #, tmp150,
 # ./include/linux/fsnotify.h:54: 	return fsnotify(inode, mask, path, FSNOTIFY_EVENT_PATH, NULL, 0);
	ldq $27,fsnotify($29)		!literal!8	 #,,,
	mov $31,$21	 #,
	mov $31,$20	 #,
	lda $19,1($31)	 #,
	mov $15,$18	 # path,
	mov $11,$17	 # mask,
	mov $12,$16	 # _47,
	jsr $26,($27),fsnotify		!lituse_jsr!8	 #,,
	ldah $29,0($26)		!gpdisp!9	 #
	lda $29,0($29)		!gpdisp!9	 #,,
	br $31,$L11	 #
	.cfi_endproc
$LFE3537:
	.end iterate_dir
	.align 2
	.align 4
	.ent fillonedir
fillonedir:
	.frame $30,48,$26,0
	.mask 0x4001e00,-48
$LFB3539:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!18	 #,,
	lda $29,0($29)		!gpdisp!18	 #,,
$fillonedir..ng:
	lda $30,-48($30)	 #,,
	.cfi_def_cfa_offset 48
	bis $31,$31,$31
	stq $11,24($30)	 #,
	.cfi_offset 11, -24
	mov $16,$11	 # tmp141, ctx
	stq $12,32($30)	 #,
	.cfi_offset 12, -16
	mov $18,$12	 # namlen, tmp142
	stq $26,0($30)	 #,
	stq $9,8($30)	 #,
	stq $10,16($30)	 #,
	.cfi_offset 26, -48
	.cfi_offset 9, -40
	.cfi_offset 10, -32
	.prologue 1
 # fs/readdir.c:187: 	if (buf->result)
	ldl $10,24($16)	 # <retval>, MEM[(struct readdir_callback *)ctx_33(D)].result
 # fs/readdir.c:187: 	if (buf->result)
	bne $10,$L27	 #, <retval>,
 # fs/readdir.c:195: 	dirent = buf->dirent;
	ldq $2,16($16)	 # MEM[(struct readdir_callback *)ctx_33(D)].dirent, dirent
 # fs/readdir.c:196: 	if (!access_ok(dirent,
	lda $1,1($18)	 # tmp113,, namlen
 # fs/readdir.c:194: 	buf->result++;
	lda $3,1($31)	 # tmp112,
	stl $3,24($16)	 # tmp112, MEM[(struct readdir_callback *)ctx_33(D)].result
 # fs/readdir.c:196: 	if (!access_ok(dirent,
	lda $9,18($2)	 # _2,, dirent
	addq $9,$1,$1	 # _2, tmp113, _6
	ldq $4,80($8)	 # __current_thread_info.3_9->addr_limit.seg, __current_thread_info.3_9->addr_limit.seg
	subq $1,$2,$3	 # _6, dirent, __ao_b
	cmpult $31,$3,$5	 # __ao_b, tmp115
	bis $2,$3,$3	 # dirent, __ao_b, tmp117
	subq $1,$5,$1	 # _6, tmp115, __ao_end
	bis $1,$3,$1	 # __ao_end, tmp117, tmp118
	and $1,$4,$1	 # tmp118, __current_thread_info.3_9->addr_limit.seg, tmp119
 # fs/readdir.c:196: 	if (!access_ok(dirent,
	bne $1,$L26	 #, tmp119,
 # fs/readdir.c:200: 	if (	__put_user(d_ino, &dirent->d_ino) ||
	mov $10,$1	 # <retval>, __pu_err
	.set	macro
 # 200 "fs/readdir.c" 1
	1: stq $20,0($2)	 # ino, MEM[(struct __large_struct *)_16]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:200: 	if (	__put_user(d_ino, &dirent->d_ino) ||
	.set	nomacro
	bne $1,$L26	 #, __pu_err,
 # fs/readdir.c:201: 		__put_user(offset, &dirent->d_offset) ||
	mov $10,$1	 # <retval>, __pu_err
	.set	macro
 # 201 "fs/readdir.c" 1
	1: stq $19,8($2)	 # offset, MEM[(struct __large_struct *)_19]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:200: 	if (	__put_user(d_ino, &dirent->d_ino) ||
	.set	nomacro
	bne $1,$L26	 #, __pu_err,
 # fs/readdir.c:202: 		__put_user(namlen, &dirent->d_namlen) ||
	.align 3 #realign	 #
	lda $2,16($2)	 # tmp131,, dirent
	mov $10,$1	 # <retval>, __pu_err
	zapnot $18,3,$3	 # namlen, namlen
	.set	macro
 # 202 "fs/readdir.c" 1
	1:	ldq_u $5,1($2)	 # __pu_tmp2, tmp131
2:	ldq_u $4,0($2)	 # __pu_tmp1, tmp131
	inswh $3,$2,$7	 # namlen, tmp131, __pu_tmp4
	inswl $3,$2,$6	 # namlen, tmp131, __pu_tmp3
	mskwh $5,$2,$5	 # __pu_tmp2, tmp131
	mskwl $4,$2,$4	 # __pu_tmp1, tmp131
	or $5,$7,$5	 # __pu_tmp2, __pu_tmp4
	or $4,$6,$4	 # __pu_tmp1, __pu_tmp3
3:	stq_u $5,1($2)	 # __pu_tmp2, tmp131
4:	stq_u $4,0($2)	 # __pu_tmp1, tmp131
5:
.section __ex_table,"a"
	.long 1b-.
	lda $31,5b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,5b-2b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 3b-.
	lda $31,5b-3b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 4b-.
	lda $31,5b-4b($1)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:201: 		__put_user(offset, &dirent->d_offset) ||
	.set	nomacro
	bne $1,$L26	 #, __pu_err,
 # ./arch/alpha/include/asm/uaccess.h:314: 	return __copy_user((__force void *)to, from, len);
	.align 3 #realign	 #
	ldq $27,__copy_user($29)		!literal!19	 #,,,
	mov $9,$16	 # _2,
	jsr $26,($27),__copy_user		!lituse_jsr!19	 #,,
	ldah $29,0($26)		!gpdisp!20	 #
	lda $29,0($29)		!gpdisp!20	 #,,
 # fs/readdir.c:202: 		__put_user(namlen, &dirent->d_namlen) ||
	bne $0,$L26	 #, tmp145,
 # fs/readdir.c:204: 		__put_user(0, dirent->d_name + namlen))
	addq $9,$12,$9	 # _2, namlen, tmp138
	mov $10,$1	 # <retval>, __pu_err
	.set	macro
 # 204 "fs/readdir.c" 1
	1:	ldq_u $2,0($9)	 # __pu_tmp1, tmp138
	insbl $10,$9,$3	 # __pu_err, tmp138, __pu_tmp2
	mskbl $2,$9,$2	 # __pu_tmp1, tmp138
	or $2,$3,$2	 # __pu_tmp1, __pu_tmp2
2:	stq_u $2,0($9)	 # __pu_tmp1, tmp138
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:203: 		__copy_to_user(dirent->d_name, name, namlen) ||
	.set	nomacro
	bne $1,$L26	 #, __pu_err,
	.align 3 #realign	 #
$L24:
 # fs/readdir.c:210: }
	mov $10,$0	 # <retval>,
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	lda $30,48($30)	 #,,
	.cfi_remember_state
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L26:
	.cfi_restore_state
 # fs/readdir.c:208: 	buf->result = -EFAULT;
	lda $1,-14($31)	 # tmp121,
 # fs/readdir.c:209: 	return -EFAULT;
	lda $10,-14($31)	 # <retval>,
 # fs/readdir.c:208: 	buf->result = -EFAULT;
	stl $1,24($11)	 # tmp121, MEM[(struct readdir_callback *)ctx_33(D)].result
 # fs/readdir.c:209: 	return -EFAULT;
	br $31,$L24	 #
	.align 4
$L27:
 # fs/readdir.c:188: 		return -EINVAL;
	lda $10,-22($31)	 # <retval>,
	br $31,$L24	 #
	.cfi_endproc
$LFE3539:
	.end fillonedir
	.section	.rodata.str1.1,"aMS",@progbits,1
$LC0:
	.string	"fs/readdir.c"
	.text
	.align 2
	.align 4
	.ent verify_dirent_name
verify_dirent_name:
	.frame $30,32,$26,0
	.mask 0x4000000,-32
$LFB3538:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!21	 #,,
	lda $29,0($29)		!gpdisp!21	 #,,
$verify_dirent_name..ng:
	lda $30,-32($30)	 #,,
	.cfi_def_cfa_offset 32
	mov $17,$18	 # tmp106, len
	stq $26,0($30)	 #,
	.cfi_offset 26, -32
	.prologue 1
 # fs/readdir.c:148: 	if (WARN_ON_ONCE(!len))
	beq $17,$L36	 #, len,
 # fs/readdir.c:150: 	if (WARN_ON_ONCE(memchr(name, '/', len)))
	ldq $27,memchr($29)		!literal!22	 #,,,
	lda $17,47($31)	 #,
	jsr $26,($27),memchr		!lituse_jsr!22	 #,,
	ldah $29,0($26)		!gpdisp!23	 #
	lda $29,0($29)		!gpdisp!23	 #,,
	bne $0,$L31	 #, tmp107,
$L34:
 # fs/readdir.c:153: }
	ldq $26,0($30)	 #,
	lda $30,32($30)	 #,,
	.cfi_remember_state
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L36:
	.cfi_restore_state
 # fs/readdir.c:148: 	if (WARN_ON_ONCE(!len))
	ldah $1,__warned.38909($29)		!gprelhigh	 # tmp77,,
 # fs/readdir.c:149: 		return -EIO;
	lda $0,-5($31)	 # <retval>,
 # fs/readdir.c:148: 	if (WARN_ON_ONCE(!len))
	ldq_u $2,__warned.38909($1)		!gprellow	 #, tmp81
	lda $3,__warned.38909($1)		!gprellow	 # tmp82,, tmp77
	extbl $2,$3,$4	 #, tmp81, tmp82, tmp78
	bne $4,$L34	 #, tmp78,
 # fs/readdir.c:148: 	if (WARN_ON_ONCE(!len))
	lda $4,1($31)	 # tmp84,
	mov $31,$19	 #,
	mskbl $2,$3,$2	 #, tmp81, tmp82, tmp86
	lda $18,9($31)	 #,
	insbl $4,$3,$3	 # tmp84, tmp82, tmp87
	lda $17,148($31)	 #,
	bis $3,$2,$3	 # tmp87, tmp86, tmp87
	stq_u $3,__warned.38909($1)		!gprellow	 #, tmp87
$L35:
 # fs/readdir.c:150: 	if (WARN_ON_ONCE(memchr(name, '/', len)))
	ldah $16,$LC0($29)		!gprelhigh	 # tmp102,,
	ldq $27,warn_slowpath_fmt($29)		!literal!24	 #,,,
	stq $0,16($30)	 #,
	lda $16,$LC0($16)		!gprellow	 #,, tmp102
	jsr $26,($27),warn_slowpath_fmt		!lituse_jsr!24	 #,,
	ldah $29,0($26)		!gpdisp!25	 #
	lda $29,0($29)		!gpdisp!25	 #,,
	ldq $0,16($30)	 #,
	br $31,$L34	 #
	.align 4
$L31:
 # fs/readdir.c:150: 	if (WARN_ON_ONCE(memchr(name, '/', len)))
	ldah $1,__warned.38914($29)		!gprelhigh	 # tmp90,,
 # fs/readdir.c:149: 		return -EIO;
	lda $0,-5($31)	 # <retval>,
 # fs/readdir.c:150: 	if (WARN_ON_ONCE(memchr(name, '/', len)))
	ldq_u $2,__warned.38914($1)		!gprellow	 #, tmp94
	lda $3,__warned.38914($1)		!gprellow	 # tmp95,, tmp90
	extbl $2,$3,$4	 #, tmp94, tmp95, tmp91
	bne $4,$L34	 #, tmp91,
 # fs/readdir.c:150: 	if (WARN_ON_ONCE(memchr(name, '/', len)))
	lda $4,1($31)	 # tmp97,
	mov $31,$19	 #,
	mskbl $2,$3,$2	 #, tmp94, tmp95, tmp99
	lda $18,9($31)	 #,
	insbl $4,$3,$3	 # tmp97, tmp95, tmp100
	lda $17,150($31)	 #,
	bis $3,$2,$3	 # tmp100, tmp99, tmp100
	stq_u $3,__warned.38914($1)		!gprellow	 #, tmp100
	br $31,$L35	 #
	.cfi_endproc
$LFE3538:
	.end verify_dirent_name
	.align 2
	.align 4
	.ent filldir
filldir:
	.frame $30,64,$26,0
	.mask 0x400fe00,-64
$LFB3542:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!26	 #,,
	lda $29,0($29)		!gpdisp!26	 #,,
$filldir..ng:
	lda $30,-64($30)	 #,,
	.cfi_def_cfa_offset 64
	bis $31,$31,$31
	stq $9,8($30)	 #,
	.cfi_offset 9, -56
	mov $17,$9	 # tmp243, name
	stq $13,40($30)	 #,
	.cfi_offset 13, -24
 # fs/readdir.c:261: 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
	addl $18,27,$13	 # namlen,, tmp143
 # fs/readdir.c:256: {
	stq $11,24($30)	 #,
 # fs/readdir.c:261: 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
	bic $13,7,$13	 # tmp143,, tmp144
	.cfi_offset 11, -40
 # fs/readdir.c:256: {
	mov $16,$11	 # ctx, tmp242
 # fs/readdir.c:264: 	buf->error = verify_dirent_name(name, namlen);
	mov $18,$17	 # namlen,
	mov $9,$16	 # name,
 # fs/readdir.c:261: 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
	addl $31,$13,$13	 # tmp144, reclen
 # fs/readdir.c:256: {
	stq $10,16($30)	 #,
	.cfi_offset 10, -48
	mov $18,$10	 # tmp244, namlen
	stq $12,32($30)	 #,
	.cfi_offset 12, -32
	mov $21,$12	 # tmp247, d_type
	stq $14,48($30)	 #,
	.cfi_offset 14, -16
	mov $20,$14	 # tmp246, ino
	stq $15,56($30)	 #,
	.cfi_offset 15, -8
	mov $19,$15	 # tmp245, offset
	stq $26,0($30)	 #,
	.cfi_offset 26, -64
	.prologue 1
 # fs/readdir.c:264: 	buf->error = verify_dirent_name(name, namlen);
	ldq $27,verify_dirent_name($29)		!literal!27	 #
	jsr $26,($27),0		!lituse_jsr!27
	ldah $29,0($26)		!gpdisp!28
	lda $29,0($29)		!gpdisp!28
 # fs/readdir.c:265: 	if (unlikely(buf->error))
	bne $0,$L60	 #, <retval>,
 # fs/readdir.c:267: 	buf->error = -EINVAL;	/* only used if we fail.. */
	lda $1,-22($31)	 # tmp147,
 # fs/readdir.c:268: 	if (reclen > buf->count)
	ldl $5,32($11)	 # _8, MEM[(struct getdents_callback *)ctx_55(D)].count
 # fs/readdir.c:267: 	buf->error = -EINVAL;	/* only used if we fail.. */
	stl $1,36($11)	 # tmp147, MEM[(struct getdents_callback *)ctx_55(D)].error
 # fs/readdir.c:268: 	if (reclen > buf->count)
	bis $31,$31,$31
	cmplt $5,$13,$1	 #, _8, reclen, tmp148
	bne $1,$L51	 #, tmp148,
 # fs/readdir.c:275: 	dirent = buf->previous;
	ldq $2,24($11)	 # MEM[(struct getdents_callback *)ctx_55(D)].previous, dirent
 # fs/readdir.c:276: 	if (dirent && signal_pending(current))
	beq $2,$L40	 #, dirent,
 # ./include/linux/sched.h:1737: 	return test_ti_thread_flag(task_thread_info(tsk), flag);
	ldq $1,64($8)	 # __current_thread_info.16_9->task, __current_thread_info.16_9->task
 # ./arch/alpha/include/asm/bitops.h:289: 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
	ldq $1,8($1)	 # _10->stack, _10->stack
 # ./arch/alpha/include/asm/bitops.h:289: 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
	ldl $1,72($1)	 # MEM[(const int *)_118 + 72B], MEM[(const int *)_118 + 72B]
 # fs/readdir.c:276: 	if (dirent && signal_pending(current))
	and $1,4,$1	 # MEM[(const int *)_118 + 72B],, tmp154
	cmpult $31,$1,$1	 # tmp154, tmp154
	bne $1,$L61	 #, tmp154,
 # fs/readdir.c:283: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	lda $1,23($2)	 # __ao_end,, dirent
	ldq $3,80($8)	 # __current_thread_info.16_9->addr_limit.seg, __current_thread_info.16_9->addr_limit.seg
	bis $1,$2,$1	 # __ao_end, dirent, tmp236
	bis $1,24,$1	 # tmp236,, tmp237
	and $1,$3,$1	 # tmp237, __current_thread_info.16_9->addr_limit.seg, tmp238
 # fs/readdir.c:283: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	bne $1,$L48	 #, tmp238,
 # fs/readdir.c:286: 		unsafe_put_user(offset, &dirent->d_off, efault_end);
	mov $0,$1	 # <retval>, __pu_err
	.set	macro
 # 286 "fs/readdir.c" 1
	1: stq $15,8($2)	 # offset, MEM[(struct __large_struct *)_19]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
	.align 3 #realign	 #
$L50:
 # fs/readdir.c:287: 	dirent = buf->current_dir;
	ldq $6,16($11)	 # MEM[(struct getdents_callback *)ctx_55(D)].current_dir, dirent
 # fs/readdir.c:288: 	unsafe_put_user(d_ino, &dirent->d_ino, efault_end);
	mov $31,$1	 #, __pu_err
	.set	macro
 # 288 "fs/readdir.c" 1
	1: stq $14,0($6)	 # ino, MEM[(struct __large_struct *)_25]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
 # fs/readdir.c:289: 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
	.align 3 #realign	 #
	zapnot $13,3,$3	 # reclen, reclen
	lda $2,16($6)	 # tmp166,, dirent
	.set	macro
 # 289 "fs/readdir.c" 1
	1:	ldq_u $7,1($2)	 # __pu_tmp2, tmp166
2:	ldq_u $4,0($2)	 # __pu_tmp1, tmp166
	inswh $3,$2,$23	 # reclen, tmp166, __pu_tmp4
	inswl $3,$2,$22	 # reclen, tmp166, __pu_tmp3
	mskwh $7,$2,$7	 # __pu_tmp2, tmp166
	mskwl $4,$2,$4	 # __pu_tmp1, tmp166
	or $7,$23,$7	 # __pu_tmp2, __pu_tmp4
	or $4,$22,$4	 # __pu_tmp1, __pu_tmp3
3:	stq_u $7,1($2)	 # __pu_tmp2, tmp166
4:	stq_u $4,0($2)	 # __pu_tmp1, tmp166
5:
.section __ex_table,"a"
	.long 1b-.
	lda $31,5b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,5b-2b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 3b-.
	lda $31,5b-3b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 4b-.
	lda $31,5b-4b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
 # fs/readdir.c:290: 	unsafe_put_user(d_type, (char __user *) dirent + reclen - 1, efault_end);
	.align 3 #realign	 #
	sll $12,56,$12	 # d_type,, tmp175
	lda $2,-1($13)	 # tmp176,, reclen
	sra $12,56,$12	 # tmp175,, tmp173
	addq $6,$2,$2	 # dirent, tmp176, tmp177
	.set	macro
 # 290 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, tmp177
	insbl $12,$2,$4	 # tmp173, tmp177, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, tmp177
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, tmp177
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	mov $10,$18	 # namlen, len
	lda $2,18($6)	 # dst,, dirent
	cmpule $10,7,$1	 #, len,, tmp179
	bne $1,$L43	 #, tmp179,
	mov $31,$7	 #, tmp187
	br $31,$L44	 #
	.align 4
$L62:
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	lda $2,8($2)	 # dst,, dst
	lda $9,8($9)	 # name,, name
	cmpule $18,7,$1	 #, len,, tmp188
	bne $1,$L43	 #, tmp188,
$L44:
 # ./include/linux/unaligned/packed_struct.h:25: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp182
	ldq_u $4,7($9)	 #, tmp183
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $7,$3	 # tmp187, __pu_err
 # ./include/linux/unaligned/packed_struct.h:25: 	return ptr->x;
	extql $1,$9,$1	 #, tmp182, name, tmp185
	extqh $4,$9,$4	 # tmp183, name, tmp186
	bis $1,$4,$1	 # tmp185, tmp186, tmp181
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.set	macro
 # 291 "fs/readdir.c" 1
	1: stq $1,0($2)	 # tmp181, MEM[(struct __large_struct *)dst_154]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	.align 3 #realign	 #
	lda $18,-8($18)	 # len,, len
	beq $3,$L62	 #, __pu_err,
$L42:
$L48:
 # fs/readdir.c:302: 	buf->error = -EFAULT;
	lda $1,-14($31)	 # tmp233,
 # fs/readdir.c:303: 	return -EFAULT;
	lda $0,-14($31)	 # <retval>,
 # fs/readdir.c:302: 	buf->error = -EFAULT;
	stl $1,36($11)	 # tmp233, MEM[(struct getdents_callback *)ctx_55(D)].error
	bis $31,$31,$31
$L57:
 # fs/readdir.c:304: }
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	ldq $13,40($30)	 #,
	ldq $14,48($30)	 #,
	ldq $15,56($30)	 #,
	lda $30,64($30)	 #,,
	.cfi_remember_state
	.cfi_restore 15
	.cfi_restore 14
	.cfi_restore 13
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L40:
	.cfi_restore_state
 # fs/readdir.c:283: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	ldq $1,80($8)	 # __current_thread_info.17_165->addr_limit.seg, __current_thread_info.17_165->addr_limit.seg
	and $1,31,$1	 # __current_thread_info.17_165->addr_limit.seg,, tmp240
 # fs/readdir.c:283: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	beq $1,$L50	 #, tmp240,
	br $31,$L48	 #
	.align 4
$L43:
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	cmpule $18,3,$1	 #, len,, tmp189
	bne $1,$L45	 #, tmp189,
 # ./include/linux/unaligned/packed_struct.h:19: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp192
	ldq_u $4,3($9)	 #, tmp193
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$3	 #, __pu_err
 # ./include/linux/unaligned/packed_struct.h:19: 	return ptr->x;
	extll $1,$9,$1	 #, tmp192, name, tmp195
	extlh $4,$9,$4	 # tmp193, name, tmp196
	bis $1,$4,$1	 # tmp195, tmp196, tmp191
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.set	macro
 # 291 "fs/readdir.c" 1
	1: stl $1,0($2)	 # tmp191, MEM[(struct __large_struct *)dst_147]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $3,$L48	 #, __pu_err,
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	lda $2,4($2)	 # dst,, dst
	lda $9,4($9)	 # name,, name
	lda $18,-4($18)	 # len,, len
	bis $31,$31,$31
$L45:
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	cmpule $18,1,$1	 #, len,, tmp201
	bne $1,$L46	 #, tmp201,
 # ./include/linux/unaligned/packed_struct.h:13: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp208
	ldq_u $4,1($9)	 #, tmp209
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$3	 #, __pu_err
 # ./include/linux/unaligned/packed_struct.h:13: 	return ptr->x;
	extwl $1,$9,$1	 #, tmp208, name, tmp211
	extwh $4,$9,$4	 # tmp209, name, tmp212
	bis $1,$4,$1	 # tmp211, tmp212, tmp207
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	zapnot $1,3,$1	 # tmp207, tmp216
	.set	macro
 # 291 "fs/readdir.c" 1
	1:	ldq_u $7,1($2)	 # __pu_tmp2, dst
2:	ldq_u $4,0($2)	 # __pu_tmp1, dst
	inswh $1,$2,$23	 # tmp216, dst, __pu_tmp4
	inswl $1,$2,$22	 # tmp216, dst, __pu_tmp3
	mskwh $7,$2,$7	 # __pu_tmp2, dst
	mskwl $4,$2,$4	 # __pu_tmp1, dst
	or $7,$23,$7	 # __pu_tmp2, __pu_tmp4
	or $4,$22,$4	 # __pu_tmp1, __pu_tmp3
3:	stq_u $7,1($2)	 # __pu_tmp2, dst
4:	stq_u $4,0($2)	 # __pu_tmp1, dst
5:
.section __ex_table,"a"
	.long 1b-.
	lda $31,5b-1b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,5b-2b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 3b-.
	lda $31,5b-3b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 4b-.
	lda $31,5b-4b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $3,$L48	 #, __pu_err,
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	lda $2,2($2)	 # dst,, dst
	lda $9,2($9)	 # name,, name
	lda $18,-2($18)	 # len,, len
$L46:
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	beq $18,$L47	 #, len,
	ldq_u $3,0($9)	 #, tmp223
	mov $31,$1	 #, __pu_err
	extbl $3,$9,$9	 #, tmp223, name, tmp221
	.set	macro
 # 291 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, dst
	insbl $9,$2,$4	 # tmp221, dst, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, dst
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, dst
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	lda $2,1($2)	 # dst,, dst
$L47:
 # fs/readdir.c:291: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$1	 #, __pu_err
	.set	macro
 # 291 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, dst
	insbl $1,$2,$4	 # __pu_err, dst, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, dst
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, dst
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L48	 #, __pu_err,
 # fs/readdir.c:295: 	dirent = (void __user *)dirent + reclen;
	.align 3 #realign	 #
	addq $6,$13,$1	 # dirent, reclen, dirent
 # fs/readdir.c:297: 	buf->count -= reclen;
	subl $5,$13,$5	 # _8, reclen, tmp232
 # fs/readdir.c:294: 	buf->previous = dirent;
	stq $6,24($11)	 # MEM[(struct getdents_callback *)ctx_55(D)].previous, dirent
 # fs/readdir.c:296: 	buf->current_dir = dirent;
	stq $1,16($11)	 # MEM[(struct getdents_callback *)ctx_55(D)].current_dir, dirent
 # fs/readdir.c:297: 	buf->count -= reclen;
	stl $5,32($11)	 # tmp232, MEM[(struct getdents_callback *)ctx_55(D)].count
 # fs/readdir.c:298: 	return 0;
	br $31,$L57	 #
	.align 4
$L60:
 # fs/readdir.c:264: 	buf->error = verify_dirent_name(name, namlen);
	stl $0,36($11)	 # <retval>, MEM[(struct getdents_callback *)ctx_55(D)].error
	br $31,$L57	 #
	.align 4
$L61:
 # fs/readdir.c:277: 		return -EINTR;
	lda $0,-4($31)	 # <retval>,
	br $31,$L57	 #
$L51:
 # fs/readdir.c:269: 		return -EINVAL;
	lda $0,-22($31)	 # <retval>,
	br $31,$L57	 #
	.cfi_endproc
$LFE3542:
	.end filldir
	.align 2
	.align 4
	.ent filldir64
filldir64:
	.frame $30,64,$26,0
	.mask 0x400fe00,-64
$LFB3545:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!29	 #,,
	lda $29,0($29)		!gpdisp!29	 #,,
$filldir64..ng:
	lda $30,-64($30)	 #,,
	.cfi_def_cfa_offset 64
	bis $31,$31,$31
	stq $9,8($30)	 #,
	.cfi_offset 9, -56
	mov $17,$9	 # tmp238, name
	stq $12,32($30)	 #,
	.cfi_offset 12, -32
 # fs/readdir.c:353: 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
	addl $18,27,$12	 # namlen,, tmp141
 # fs/readdir.c:349: {
	stq $11,24($30)	 #,
 # fs/readdir.c:353: 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
	bic $12,7,$12	 # tmp141,, tmp142
	.cfi_offset 11, -40
 # fs/readdir.c:349: {
	mov $16,$11	 # ctx, tmp237
 # fs/readdir.c:356: 	buf->error = verify_dirent_name(name, namlen);
	mov $18,$17	 # namlen,
	mov $9,$16	 # name,
 # fs/readdir.c:353: 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
	addl $31,$12,$12	 # tmp142, reclen
 # fs/readdir.c:349: {
	stq $10,16($30)	 #,
	.cfi_offset 10, -48
	mov $18,$10	 # tmp239, namlen
	stq $13,40($30)	 #,
	.cfi_offset 13, -24
	mov $21,$13	 # tmp242, d_type
	stq $14,48($30)	 #,
	.cfi_offset 14, -16
	mov $20,$14	 # tmp241, ino
	stq $15,56($30)	 #,
	.cfi_offset 15, -8
	mov $19,$15	 # tmp240, offset
	stq $26,0($30)	 #,
	.cfi_offset 26, -64
	.prologue 1
 # fs/readdir.c:356: 	buf->error = verify_dirent_name(name, namlen);
	ldq $27,verify_dirent_name($29)		!literal!30	 #
	jsr $26,($27),0		!lituse_jsr!30
	ldah $29,0($26)		!gpdisp!31
	lda $29,0($29)		!gpdisp!31
 # fs/readdir.c:357: 	if (unlikely(buf->error))
	bne $0,$L86	 #, <retval>,
 # fs/readdir.c:359: 	buf->error = -EINVAL;	/* only used if we fail.. */
	lda $1,-22($31)	 # tmp145,
 # fs/readdir.c:360: 	if (reclen > buf->count)
	ldl $5,32($11)	 # _8, MEM[(struct getdents_callback64 *)ctx_45(D)].count
 # fs/readdir.c:359: 	buf->error = -EINVAL;	/* only used if we fail.. */
	stl $1,36($11)	 # tmp145, MEM[(struct getdents_callback64 *)ctx_45(D)].error
 # fs/readdir.c:360: 	if (reclen > buf->count)
	bis $31,$31,$31
	cmplt $5,$12,$1	 #, _8, reclen, tmp146
	bne $1,$L77	 #, tmp146,
 # fs/readdir.c:362: 	dirent = buf->previous;
	ldq $2,24($11)	 # MEM[(struct getdents_callback64 *)ctx_45(D)].previous, dirent
 # fs/readdir.c:363: 	if (dirent && signal_pending(current))
	beq $2,$L66	 #, dirent,
 # ./include/linux/sched.h:1737: 	return test_ti_thread_flag(task_thread_info(tsk), flag);
	ldq $1,64($8)	 # __current_thread_info.30_9->task, __current_thread_info.30_9->task
 # ./arch/alpha/include/asm/bitops.h:289: 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
	ldq $1,8($1)	 # _10->stack, _10->stack
 # ./arch/alpha/include/asm/bitops.h:289: 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
	ldl $1,72($1)	 # MEM[(const int *)_115 + 72B], MEM[(const int *)_115 + 72B]
 # fs/readdir.c:363: 	if (dirent && signal_pending(current))
	and $1,4,$1	 # MEM[(const int *)_115 + 72B],, tmp152
	cmpult $31,$1,$1	 # tmp152, tmp152
	bne $1,$L87	 #, tmp152,
 # fs/readdir.c:370: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	lda $1,23($2)	 # __ao_end,, dirent
	ldq $3,80($8)	 # __current_thread_info.30_9->addr_limit.seg, __current_thread_info.30_9->addr_limit.seg
	bis $1,$2,$1	 # __ao_end, dirent, tmp231
	bis $1,24,$1	 # tmp231,, tmp232
	and $1,$3,$1	 # tmp232, __current_thread_info.30_9->addr_limit.seg, tmp233
 # fs/readdir.c:370: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	bne $1,$L74	 #, tmp233,
 # fs/readdir.c:373: 		unsafe_put_user(offset, &dirent->d_off, efault_end);
	mov $0,$1	 # <retval>, __pu_err
	.set	macro
 # 373 "fs/readdir.c" 1
	1: stq $15,8($2)	 # offset, MEM[(struct __large_struct *)_18]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
	.align 3 #realign	 #
$L76:
 # fs/readdir.c:374: 	dirent = buf->current_dir;
	ldq $6,16($11)	 # MEM[(struct getdents_callback64 *)ctx_45(D)].current_dir, dirent
 # fs/readdir.c:375: 	unsafe_put_user(ino, &dirent->d_ino, efault_end);
	mov $31,$1	 #, __pu_err
	.set	macro
 # 375 "fs/readdir.c" 1
	1: stq $14,0($6)	 # ino, MEM[(struct __large_struct *)_24]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
 # fs/readdir.c:376: 	unsafe_put_user(reclen, &dirent->d_reclen, efault_end);
	.align 3 #realign	 #
	zapnot $12,3,$3	 # reclen, reclen
	lda $2,16($6)	 # tmp164,, dirent
	.set	macro
 # 376 "fs/readdir.c" 1
	1:	ldq_u $7,1($2)	 # __pu_tmp2, tmp164
2:	ldq_u $4,0($2)	 # __pu_tmp1, tmp164
	inswh $3,$2,$23	 # reclen, tmp164, __pu_tmp4
	inswl $3,$2,$22	 # reclen, tmp164, __pu_tmp3
	mskwh $7,$2,$7	 # __pu_tmp2, tmp164
	mskwl $4,$2,$4	 # __pu_tmp1, tmp164
	or $7,$23,$7	 # __pu_tmp2, __pu_tmp4
	or $4,$22,$4	 # __pu_tmp1, __pu_tmp3
3:	stq_u $7,1($2)	 # __pu_tmp2, tmp164
4:	stq_u $4,0($2)	 # __pu_tmp1, tmp164
5:
.section __ex_table,"a"
	.long 1b-.
	lda $31,5b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,5b-2b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 3b-.
	lda $31,5b-3b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 4b-.
	lda $31,5b-4b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
 # fs/readdir.c:377: 	unsafe_put_user(d_type, &dirent->d_type, efault_end);
	.align 3 #realign	 #
	and $13,0xff,$13	 # d_type, d_type
	lda $2,18($6)	 # tmp172,, dirent
	.set	macro
 # 377 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, tmp172
	insbl $13,$2,$4	 # d_type, tmp172, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, tmp172
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, tmp172
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	mov $10,$18	 # namlen, len
	lda $2,19($6)	 # dst,, dirent
	cmpule $10,7,$1	 #, len,, tmp174
	bne $1,$L69	 #, tmp174,
	mov $31,$7	 #, tmp182
	br $31,$L70	 #
	.align 4
$L88:
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	lda $2,8($2)	 # dst,, dst
	lda $9,8($9)	 # name,, name
	cmpule $18,7,$1	 #, len,, tmp183
	bne $1,$L69	 #, tmp183,
$L70:
 # ./include/linux/unaligned/packed_struct.h:25: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp177
	ldq_u $4,7($9)	 #, tmp178
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $7,$3	 # tmp182, __pu_err
 # ./include/linux/unaligned/packed_struct.h:25: 	return ptr->x;
	extql $1,$9,$1	 #, tmp177, name, tmp180
	extqh $4,$9,$4	 # tmp178, name, tmp181
	bis $1,$4,$1	 # tmp180, tmp181, tmp176
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.set	macro
 # 378 "fs/readdir.c" 1
	1: stq $1,0($2)	 # tmp176, MEM[(struct __large_struct *)dst_152]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	.align 3 #realign	 #
	lda $18,-8($18)	 # len,, len
	beq $3,$L88	 #, __pu_err,
$L68:
$L74:
 # fs/readdir.c:389: 	buf->error = -EFAULT;
	lda $1,-14($31)	 # tmp228,
 # fs/readdir.c:390: 	return -EFAULT;
	lda $0,-14($31)	 # <retval>,
 # fs/readdir.c:389: 	buf->error = -EFAULT;
	stl $1,36($11)	 # tmp228, MEM[(struct getdents_callback64 *)ctx_45(D)].error
	bis $31,$31,$31
$L83:
 # fs/readdir.c:391: }
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	ldq $13,40($30)	 #,
	ldq $14,48($30)	 #,
	ldq $15,56($30)	 #,
	lda $30,64($30)	 #,,
	.cfi_remember_state
	.cfi_restore 15
	.cfi_restore 14
	.cfi_restore 13
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L66:
	.cfi_restore_state
 # fs/readdir.c:370: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	ldq $1,80($8)	 # __current_thread_info.31_163->addr_limit.seg, __current_thread_info.31_163->addr_limit.seg
	and $1,31,$1	 # __current_thread_info.31_163->addr_limit.seg,, tmp235
 # fs/readdir.c:370: 	if (!user_access_begin(dirent, sizeof(*dirent)))
	beq $1,$L76	 #, tmp235,
	br $31,$L74	 #
	.align 4
$L69:
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	cmpule $18,3,$1	 #, len,, tmp184
	bne $1,$L71	 #, tmp184,
 # ./include/linux/unaligned/packed_struct.h:19: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp187
	ldq_u $4,3($9)	 #, tmp188
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$3	 #, __pu_err
 # ./include/linux/unaligned/packed_struct.h:19: 	return ptr->x;
	extll $1,$9,$1	 #, tmp187, name, tmp190
	extlh $4,$9,$4	 # tmp188, name, tmp191
	bis $1,$4,$1	 # tmp190, tmp191, tmp186
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.set	macro
 # 378 "fs/readdir.c" 1
	1: stl $1,0($2)	 # tmp186, MEM[(struct __large_struct *)dst_145]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $3,$L74	 #, __pu_err,
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	lda $2,4($2)	 # dst,, dst
	lda $9,4($9)	 # name,, name
	lda $18,-4($18)	 # len,, len
	bis $31,$31,$31
$L71:
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	cmpule $18,1,$1	 #, len,, tmp196
	bne $1,$L72	 #, tmp196,
 # ./include/linux/unaligned/packed_struct.h:13: 	return ptr->x;
	ldq_u $1,0($9)	 #, tmp203
	ldq_u $4,1($9)	 #, tmp204
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$3	 #, __pu_err
 # ./include/linux/unaligned/packed_struct.h:13: 	return ptr->x;
	extwl $1,$9,$1	 #, tmp203, name, tmp206
	extwh $4,$9,$4	 # tmp204, name, tmp207
	bis $1,$4,$1	 # tmp206, tmp207, tmp202
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	zapnot $1,3,$1	 # tmp202, tmp211
	.set	macro
 # 378 "fs/readdir.c" 1
	1:	ldq_u $7,1($2)	 # __pu_tmp2, dst
2:	ldq_u $4,0($2)	 # __pu_tmp1, dst
	inswh $1,$2,$23	 # tmp211, dst, __pu_tmp4
	inswl $1,$2,$22	 # tmp211, dst, __pu_tmp3
	mskwh $7,$2,$7	 # __pu_tmp2, dst
	mskwl $4,$2,$4	 # __pu_tmp1, dst
	or $7,$23,$7	 # __pu_tmp2, __pu_tmp4
	or $4,$22,$4	 # __pu_tmp1, __pu_tmp3
3:	stq_u $7,1($2)	 # __pu_tmp2, dst
4:	stq_u $4,0($2)	 # __pu_tmp1, dst
5:
.section __ex_table,"a"
	.long 1b-.
	lda $31,5b-1b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,5b-2b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 3b-.
	lda $31,5b-3b($3)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 4b-.
	lda $31,5b-4b($3)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $3,$L74	 #, __pu_err,
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	.align 3 #realign	 #
	lda $2,2($2)	 # dst,, dst
	lda $9,2($9)	 # name,, name
	lda $18,-2($18)	 # len,, len
$L72:
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	beq $18,$L73	 #, len,
	ldq_u $3,0($9)	 #, tmp218
	mov $31,$1	 #, __pu_err
	extbl $3,$9,$9	 #, tmp218, name, tmp216
	.set	macro
 # 378 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, dst
	insbl $9,$2,$4	 # tmp216, dst, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, dst
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, dst
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	lda $2,1($2)	 # dst,, dst
$L73:
 # fs/readdir.c:378: 	unsafe_copy_dirent_name(dirent->d_name, name, namlen, efault_end);
	mov $31,$1	 #, __pu_err
	.set	macro
 # 378 "fs/readdir.c" 1
	1:	ldq_u $3,0($2)	 # __pu_tmp1, dst
	insbl $1,$2,$4	 # __pu_err, dst, __pu_tmp2
	mskbl $3,$2,$3	 # __pu_tmp1, dst
	or $3,$4,$3	 # __pu_tmp1, __pu_tmp2
2:	stq_u $3,0($2)	 # __pu_tmp1, dst
3:
.section __ex_table,"a"
	.long 1b-.
	lda $31,3b-1b($1)	 # __pu_err
.previous
.section __ex_table,"a"
	.long 2b-.
	lda $31,3b-2b($1)	 # __pu_err
.previous

 # 0 "" 2
	.set	nomacro
	bne $1,$L74	 #, __pu_err,
 # fs/readdir.c:382: 	dirent = (void __user *)dirent + reclen;
	.align 3 #realign	 #
	addq $6,$12,$1	 # dirent, reclen, dirent
 # fs/readdir.c:384: 	buf->count -= reclen;
	subl $5,$12,$5	 # _8, reclen, tmp227
 # fs/readdir.c:381: 	buf->previous = dirent;
	stq $6,24($11)	 # MEM[(struct getdents_callback64 *)ctx_45(D)].previous, dirent
 # fs/readdir.c:383: 	buf->current_dir = dirent;
	stq $1,16($11)	 # MEM[(struct getdents_callback64 *)ctx_45(D)].current_dir, dirent
 # fs/readdir.c:384: 	buf->count -= reclen;
	stl $5,32($11)	 # tmp227, MEM[(struct getdents_callback64 *)ctx_45(D)].count
 # fs/readdir.c:385: 	return 0;
	br $31,$L83	 #
	.align 4
$L86:
 # fs/readdir.c:356: 	buf->error = verify_dirent_name(name, namlen);
	stl $0,36($11)	 # <retval>, MEM[(struct getdents_callback64 *)ctx_45(D)].error
	br $31,$L83	 #
	.align 4
$L87:
 # fs/readdir.c:364: 		return -EINTR;
	lda $0,-4($31)	 # <retval>,
	br $31,$L83	 #
$L77:
 # fs/readdir.c:361: 		return -EINVAL;
	lda $0,-22($31)	 # <retval>,
	br $31,$L83	 #
	.cfi_endproc
$LFE3545:
	.end filldir64
	.align 2
	.align 4
	.globl __se_sys_old_readdir
	.ent __se_sys_old_readdir
__se_sys_old_readdir:
	.frame $30,64,$26,0
	.mask 0x4000e00,-64
$LFB3540:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!32	 #,,
	lda $29,0($29)		!gpdisp!32	 #,,
$__se_sys_old_readdir..ng:
	lda $30,-64($30)	 #,,
	.cfi_def_cfa_offset 64
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	ldq $27,__fdget_pos($29)		!literal!37	 #,,,
 # fs/readdir.c:212: SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
	stq $9,8($30)	 #,
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	addl $31,$16,$16	 # tmp100,
 # fs/readdir.c:212: SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
	stq $10,16($30)	 #,
	.cfi_offset 9, -56
	.cfi_offset 10, -48
	mov $17,$10	 # tmp101, dirent
	stq $11,24($30)	 #,
	stq $26,0($30)	 #,
	.cfi_offset 11, -40
	.cfi_offset 26, -64
	.prologue 1
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	jsr $26,($27),__fdget_pos		!lituse_jsr!37	 #,,
	ldah $29,0($26)		!gpdisp!38	 #
 # fs/readdir.c:217: 	struct readdir_callback buf = {
	stq $31,40($30)	 # MEM[(struct readdir_callback *)&buf + 8B],
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	lda $29,0($29)		!gpdisp!38	 #,,
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	bic $0,3,$11	 # _9,, _11
 # fs/readdir.c:217: 	struct readdir_callback buf = {
	ldq_u $31,0($30)
	ldah $1,fillonedir($29)		!gprelhigh	 # tmp88,,
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	addl $31,$0,$9	 # _9, _12
 # fs/readdir.c:217: 	struct readdir_callback buf = {
	lda $1,fillonedir($1)		!gprellow	 # tmp87,, tmp88
 # fs/readdir.c:223: 		return -EBADF;
	lda $0,-9($31)	 # <retval>,
 # fs/readdir.c:217: 	struct readdir_callback buf = {
	stq $31,56($30)	 # MEM[(struct readdir_callback *)&buf + 8B],
	stq $1,32($30)	 # buf.ctx.actor, tmp87
	stq $10,48($30)	 # buf.dirent, dirent
 # fs/readdir.c:222: 	if (!f.file)
	beq $11,$L89	 #, _11,
 # fs/readdir.c:225: 	error = iterate_dir(f.file, &buf.ctx);
	lda $17,32($30)	 #,,
	mov $11,$16	 # _11,
	ldq $27,iterate_dir($29)		!literal!39	 #
	jsr $26,($27),0		!lituse_jsr!39
	ldah $29,0($26)		!gpdisp!40
	lda $29,0($29)		!gpdisp!40
	mov $0,$10	 #, tmp103
 # fs/readdir.c:226: 	if (buf.result)
	ldl $0,56($30)	 # _15, buf.result
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $9,2,$1	 # _12,, tmp94
 # fs/readdir.c:226: 	if (buf.result)
	cmovne $0,$0,$10	 #, _15, _15, error
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	bne $1,$L104	 #, tmp94,
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	blbs $9,$L105	 # _12,
$L93:
 # fs/readdir.c:230: 	return error;
	mov $10,$0	 # error, <retval>
$L89:
 # fs/readdir.c:212: SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	bis $31,$31,$31
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	lda $30,64($30)	 #,,
	.cfi_remember_state
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L105:
	.cfi_restore_state
 # ./include/linux/file.h:44: 		fput(fd.file);
	ldq $27,fput($29)		!literal!33	 #,,,
	mov $11,$16	 # _11,
	jsr $26,($27),fput		!lituse_jsr!33	 #,,
	ldah $29,0($26)		!gpdisp!34	 #
	lda $29,0($29)		!gpdisp!34	 #,,
	br $31,$L93	 #
	.align 4
$L104:
 # ./include/linux/file.h:78: 		__f_unlock_pos(f.file);
	ldq $27,__f_unlock_pos($29)		!literal!35	 #,,,
	mov $11,$16	 # _11,
	jsr $26,($27),__f_unlock_pos		!lituse_jsr!35	 #,,
	ldah $29,0($26)		!gpdisp!36	 #
	lda $29,0($29)		!gpdisp!36	 #,,
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	blbc $9,$L93	 # _12,
	br $31,$L105	 #
	.cfi_endproc
$LFE3540:
	.end __se_sys_old_readdir
	.globl sys_old_readdir
$sys_old_readdir..ng = $__se_sys_old_readdir..ng
sys_old_readdir = __se_sys_old_readdir
	.align 2
	.align 4
	.globl __se_sys_getdents
	.ent __se_sys_getdents
__se_sys_getdents:
	.frame $30,96,$26,0
	.mask 0x4001e00,-96
$LFB3543:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!41	 #,,
	lda $29,0($29)		!gpdisp!41	 #,,
$__se_sys_getdents..ng:
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	zapnot $18,15,$2	 # count,, __ao_b
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	lda $30,-96($30)	 #,,
	.cfi_def_cfa_offset 96
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	cmpult $31,$2,$3	 # __ao_b, tmp119
	addq $17,$2,$1	 # dirent, __ao_b, tmp117
	subq $1,$3,$1	 # tmp117, tmp119, __ao_end
	bis $17,$2,$2	 # dirent, __ao_b, tmp121
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	stq $10,16($30)	 #,
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	bis $1,$2,$1	 # __ao_end, tmp121, tmp122
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	stq $11,24($30)	 #,
 # fs/readdir.c:311: 	struct getdents_callback buf = {
	ldah $2,filldir($29)		!gprelhigh	 # tmp116,,
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	stq $26,0($30)	 #,
 # fs/readdir.c:311: 	struct getdents_callback buf = {
	lda $2,filldir($2)		!gprellow	 # tmp115,, tmp116
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	stq $9,8($30)	 #,
	.cfi_offset 10, -80
	.cfi_offset 11, -72
	.cfi_offset 26, -96
	.cfi_offset 9, -88
	mov $18,$10	 # tmp152, count
	stq $12,32($30)	 #,
	.cfi_offset 12, -64
	.prologue 1
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	addl $31,$16,$16	 # tmp150, _1
 # fs/readdir.c:311: 	struct getdents_callback buf = {
	stq $31,80($30)	 # MEM[(struct getdents_callback *)&buf + 8B],
 # fs/readdir.c:319: 		return -EFAULT;
	lda $11,-14($31)	 # <retval>,
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	ldq $3,80($8)	 # __current_thread_info.12_17->addr_limit.seg, __current_thread_info.12_17->addr_limit.seg
 # fs/readdir.c:311: 	struct getdents_callback buf = {
	stq $31,56($30)	 # MEM[(struct getdents_callback *)&buf + 8B],
	stq $31,72($30)	 # MEM[(struct getdents_callback *)&buf + 8B],
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	and $1,$3,$1	 # tmp122, __current_thread_info.12_17->addr_limit.seg, tmp123
 # fs/readdir.c:311: 	struct getdents_callback buf = {
	stq $2,48($30)	 # buf.ctx.actor, tmp115
	stq $17,64($30)	 # buf.current_dir, dirent
	stl $18,80($30)	 # count, buf.count
 # fs/readdir.c:318: 	if (!access_ok(dirent, count))
	bne $1,$L106	 #, tmp123,
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	ldq $27,__fdget_pos($29)		!literal!46	 #,,,
	bis $31,$31,$31
	jsr $26,($27),__fdget_pos		!lituse_jsr!46	 #,,
	ldah $29,0($26)		!gpdisp!47	 #
	lda $29,0($29)		!gpdisp!47	 #,,
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	bic $0,3,$12	 # _22,, _24
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	addl $31,$0,$9	 # _22, _25
 # fs/readdir.c:322: 	if (!f.file)
	beq $12,$L114	 #, _24,
 # fs/readdir.c:325: 	error = iterate_dir(f.file, &buf.ctx);
	lda $17,48($30)	 #,,
	mov $12,$16	 # _24,
	ldq $27,iterate_dir($29)		!literal!48	 #
	jsr $26,($27),0		!lituse_jsr!48
	ldah $29,0($26)		!gpdisp!49
	lda $29,0($29)		!gpdisp!49
 # fs/readdir.c:327: 		error = buf.error;
	ldl $1,84($30)	 # buf.error, buf.error
 # fs/readdir.c:328: 	lastdirent = buf.previous;
	ldq $3,72($30)	 # buf.previous, lastdirent
 # fs/readdir.c:327: 		error = buf.error;
	cmovge $0,$1,$0	 #, tmp154, buf.error, error
 # fs/readdir.c:329: 	if (lastdirent) {
	beq $3,$L123	 #, lastdirent,
 # fs/readdir.c:330: 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
	lda $2,15($3)	 # __ao_end,, lastdirent
	lda $1,8($3)	 # __pu_addr,, lastdirent
	bis $2,$1,$1	 # __ao_end, __pu_addr, tmp130
	ldq $2,80($8)	 # __current_thread_info.14_33->addr_limit.seg, __current_thread_info.14_33->addr_limit.seg
	bis $1,8,$1	 # tmp130,, tmp131
	bis $31,$31,$31
	and $1,$2,$1	 # tmp131, __current_thread_info.14_33->addr_limit.seg, tmp132
	bne $1,$L110	 #, tmp132,
	ldq $2,56($30)	 # buf.ctx.pos, buf.ctx.pos
	.set	macro
 # 330 "fs/readdir.c" 1
	1: stq $2,8($3)	 # buf.ctx.pos, MEM[(struct __large_struct *)__pu_addr_30]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($1)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:330: 		if (put_user(buf.ctx.pos, &lastdirent->d_off))
	.set	nomacro
	beq $1,$L124	 #, __pu_err,
	.align 3 #realign	 #
$L110:
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $9,2,$1	 # _25,, tmp142
	bne $1,$L125	 #, tmp142,
$L111:
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	bis $31,$31,$31
	blbs $9,$L126	 # _25,
$L106:
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	mov $11,$0	 # <retval>,
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	lda $30,96($30)	 #,,
	.cfi_remember_state
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L125:
	.cfi_restore_state
 # ./include/linux/file.h:78: 		__f_unlock_pos(f.file);
	ldq $27,__f_unlock_pos($29)		!literal!44	 #,,,
	mov $12,$16	 # _24,
	jsr $26,($27),__f_unlock_pos		!lituse_jsr!44	 #,,
	ldah $29,0($26)		!gpdisp!45	 #
	lda $29,0($29)		!gpdisp!45	 #,,
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	blbc $9,$L106	 # _25,
$L126:
 # ./include/linux/file.h:44: 		fput(fd.file);
	ldq $27,fput($29)		!literal!42	 #,,,
	mov $12,$16	 # _24,
	jsr $26,($27),fput		!lituse_jsr!42	 #,,
	ldah $29,0($26)		!gpdisp!43	 #
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	ldq $9,8($30)	 #,
	bis $31,$31,$31
	mov $11,$0	 # <retval>,
	ldq $26,0($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
 # ./include/linux/file.h:44: 		fput(fd.file);
	lda $29,0($29)		!gpdisp!43	 #,,
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	lda $30,96($30)	 #,,
	.cfi_remember_state
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L123:
	.cfi_restore_state
	mov $0,$11	 # error, <retval>
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $9,2,$1	 # _25,, tmp142
	beq $1,$L111	 #, tmp142,
	br $31,$L125	 #
	.align 4
$L124:
 # fs/readdir.c:333: 			error = count - buf.count;
	ldl $11,80($30)	 #, buf.count
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $9,2,$1	 # _25,, tmp142
	subl $10,$11,$11	 # count, buf.count, <retval>
	beq $1,$L111	 #, tmp142,
	br $31,$L125	 #
$L114:
 # fs/readdir.c:323: 		return -EBADF;
	lda $11,-9($31)	 # <retval>,
 # fs/readdir.c:306: SYSCALL_DEFINE3(getdents, unsigned int, fd,
	br $31,$L106	 #
	.cfi_endproc
$LFE3543:
	.end __se_sys_getdents
	.globl sys_getdents
$sys_getdents..ng = $__se_sys_getdents..ng
sys_getdents = __se_sys_getdents
	.align 2
	.align 4
	.globl ksys_getdents64
	.ent ksys_getdents64
ksys_getdents64:
	.frame $30,96,$26,0
	.mask 0x4003e00,-96
$LFB3546:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!50	 #,,
	lda $29,0($29)		!gpdisp!50	 #,,
$ksys_getdents64..ng:
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	zapnot $18,15,$1	 # count, __ao_b
 # fs/readdir.c:395: {
	lda $30,-96($30)	 #,,
	.cfi_def_cfa_offset 96
	stq $9,8($30)	 #,
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	cmpult $31,$1,$2	 # __ao_b, tmp105
 # fs/readdir.c:395: {
	stq $10,16($30)	 #,
	.cfi_offset 9, -88
	.cfi_offset 10, -80
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	addq $17,$1,$9	 # dirent, __ao_b, tmp103
	subq $9,$2,$9	 # tmp103, tmp105, __ao_end
	bis $17,$1,$1	 # dirent, __ao_b, tmp107
 # fs/readdir.c:395: {
	stq $12,32($30)	 #,
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	bis $9,$1,$9	 # __ao_end, tmp107, tmp108
 # fs/readdir.c:395: {
	stq $26,0($30)	 #,
 # fs/readdir.c:398: 	struct getdents_callback64 buf = {
	ldah $1,filldir64($29)		!gprelhigh	 # tmp102,,
 # fs/readdir.c:395: {
	stq $11,24($30)	 #,
 # fs/readdir.c:398: 	struct getdents_callback64 buf = {
	lda $1,filldir64($1)		!gprellow	 # tmp101,, tmp102
 # fs/readdir.c:395: {
	stq $13,40($30)	 #,
	.cfi_offset 12, -64
	.cfi_offset 26, -96
	.cfi_offset 11, -72
	.cfi_offset 13, -56
	.prologue 1
 # fs/readdir.c:395: {
	mov $18,$12	 # tmp132, count
 # fs/readdir.c:398: 	struct getdents_callback64 buf = {
	stq $31,80($30)	 # MEM[(struct getdents_callback64 *)&buf + 8B],
 # fs/readdir.c:406: 		return -EFAULT;
	lda $10,-14($31)	 # <retval>,
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	ldq $2,80($8)	 # __current_thread_info.25_5->addr_limit.seg, __current_thread_info.25_5->addr_limit.seg
 # fs/readdir.c:398: 	struct getdents_callback64 buf = {
	stq $31,56($30)	 # MEM[(struct getdents_callback64 *)&buf + 8B],
	stq $31,72($30)	 # MEM[(struct getdents_callback64 *)&buf + 8B],
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	and $9,$2,$9	 # tmp108, __current_thread_info.25_5->addr_limit.seg, tmp109
 # fs/readdir.c:398: 	struct getdents_callback64 buf = {
	stq $1,48($30)	 # buf.ctx.actor, tmp101
	stq $17,64($30)	 # buf.current_dir, dirent
	stl $18,80($30)	 # count, buf.count
 # fs/readdir.c:405: 	if (!access_ok(dirent, count))
	bne $9,$L128	 #, tmp109,
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	ldq $27,__fdget_pos($29)		!literal!55	 #,,,
 # fs/readdir.c:410: 		return -EBADF;
	lda $10,-9($31)	 # <retval>,
 # ./include/linux/file.h:72: 	return __to_fd(__fdget_pos(fd));
	jsr $26,($27),__fdget_pos		!lituse_jsr!55	 #,,
	ldah $29,0($26)		!gpdisp!56	 #
	lda $29,0($29)		!gpdisp!56	 #,,
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	bic $0,3,$13	 # _38,, _40
 # ./include/linux/file.h:57: 	return (struct fd){(struct file *)(v & ~3),v & 3};
	addl $31,$0,$11	 # _38, _41
 # fs/readdir.c:409: 	if (!f.file)
	beq $13,$L128	 #, _40,
 # fs/readdir.c:412: 	error = iterate_dir(f.file, &buf.ctx);
	lda $17,48($30)	 #,,
	mov $13,$16	 # _40,
	ldq $27,iterate_dir($29)		!literal!57	 #
	jsr $26,($27),0		!lituse_jsr!57
	ldah $29,0($26)		!gpdisp!58
	lda $29,0($29)		!gpdisp!58
 # fs/readdir.c:414: 		error = buf.error;
	ldl $10,84($30)	 # buf.error, buf.error
 # fs/readdir.c:415: 	lastdirent = buf.previous;
	ldq $1,72($30)	 # buf.previous, lastdirent
 # fs/readdir.c:414: 		error = buf.error;
	cmovlt $0,$0,$10	 #, tmp134, tmp134, <retval>
 # fs/readdir.c:416: 	if (lastdirent) {
	beq $1,$L130	 #, lastdirent,
 # fs/readdir.c:418: 		if (__put_user(d_off, &lastdirent->d_off))
	ldq $2,56($30)	 # buf.ctx.pos, buf.ctx.pos
	.set	macro
 # 418 "fs/readdir.c" 1
	1: stq $2,8($1)	 # buf.ctx.pos, MEM[(struct __large_struct *)_15]
2:
.section __ex_table,"a"
	.long 1b-.
	lda $31,2b-1b($9)	 # __pu_err
.previous

 # 0 "" 2
 # fs/readdir.c:419: 			error = -EFAULT;
	.set	nomacro
	.align 3 #realign	 #
	lda $10,-14($31)	 # <retval>,
 # fs/readdir.c:418: 		if (__put_user(d_off, &lastdirent->d_off))
	beq $9,$L144	 #, __pu_err,
$L130:
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $11,2,$1	 # _41,, tmp123
	bne $1,$L145	 #, tmp123,
$L131:
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	bis $31,$31,$31
	blbs $11,$L146	 # _41,
$L128:
 # fs/readdir.c:425: }
	mov $10,$0	 # <retval>,
	ldq $26,0($30)	 #,
	ldq $9,8($30)	 #,
	ldq $10,16($30)	 #,
	ldq $11,24($30)	 #,
	ldq $12,32($30)	 #,
	ldq $13,40($30)	 #,
	bis $31,$31,$31
	lda $30,96($30)	 #,,
	.cfi_remember_state
	.cfi_restore 13
	.cfi_restore 12
	.cfi_restore 11
	.cfi_restore 10
	.cfi_restore 9
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.align 4
$L144:
	.cfi_restore_state
 # fs/readdir.c:421: 			error = count - buf.count;
	ldl $10,80($30)	 #, buf.count
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	and $11,2,$1	 # _41,, tmp123
 # fs/readdir.c:421: 			error = count - buf.count;
	subl $12,$10,$10	 # count, buf.count, <retval>
 # ./include/linux/file.h:77: 	if (f.flags & FDPUT_POS_UNLOCK)
	beq $1,$L131	 #, tmp123,
$L145:
 # ./include/linux/file.h:78: 		__f_unlock_pos(f.file);
	ldq $27,__f_unlock_pos($29)		!literal!53	 #,,,
	mov $13,$16	 # _40,
	jsr $26,($27),__f_unlock_pos		!lituse_jsr!53	 #,,
	ldah $29,0($26)		!gpdisp!54	 #
	lda $29,0($29)		!gpdisp!54	 #,,
 # ./include/linux/file.h:43: 	if (fd.flags & FDPUT_FPUT)
	blbc $11,$L128	 # _41,
$L146:
 # ./include/linux/file.h:44: 		fput(fd.file);
	ldq $27,fput($29)		!literal!51	 #,,,
	mov $13,$16	 # _40,
	jsr $26,($27),fput		!lituse_jsr!51	 #,,
	ldah $29,0($26)		!gpdisp!52	 #
	lda $29,0($29)		!gpdisp!52	 #,,
	br $31,$L128	 #
	.cfi_endproc
$LFE3546:
	.end ksys_getdents64
	.align 2
	.align 4
	.globl __se_sys_getdents64
	.ent __se_sys_getdents64
__se_sys_getdents64:
	.frame $30,16,$26,0
	.mask 0x4000000,-16
$LFB3547:
	.cfi_startproc
	ldah $29,0($27)		!gpdisp!59	 #,,
	lda $29,0($29)		!gpdisp!59	 #,,
$__se_sys_getdents64..ng:
	lda $30,-16($30)	 #,,
	.cfi_def_cfa_offset 16
 # fs/readdir.c:431: 	return ksys_getdents64(fd, dirent, count);
	addl $31,$18,$18	 # tmp84,
 # fs/readdir.c:428: SYSCALL_DEFINE3(getdents64, unsigned int, fd,
	stq $26,0($30)	 #,
	.cfi_offset 26, -16
	.prologue 1
 # fs/readdir.c:431: 	return ksys_getdents64(fd, dirent, count);
	addl $31,$16,$16	 # tmp83,
	ldq $27,ksys_getdents64($29)		!literal!60	 #
	jsr $26,($27),0		!lituse_jsr!60
	ldah $29,0($26)		!gpdisp!61
	lda $29,0($29)		!gpdisp!61
 # fs/readdir.c:428: SYSCALL_DEFINE3(getdents64, unsigned int, fd,
	ldq $26,0($30)	 #,
	bis $31,$31,$31
	lda $30,16($30)	 #,,
	.cfi_restore 26
	.cfi_def_cfa_offset 0
	ret $31,($26),1
	.cfi_endproc
$LFE3547:
	.end __se_sys_getdents64
	.globl sys_getdents64
$sys_getdents64..ng = $__se_sys_getdents64..ng
sys_getdents64 = __se_sys_getdents64
	.section	.data.once,"aw"
	.type	__warned.38914, @object
	.size	__warned.38914, 1
__warned.38914:
	.zero	1
	.type	__warned.38909, @object
	.size	__warned.38909, 1
__warned.38909:
	.zero	1
	.section	___ksymtab+iterate_dir,"a"
	.align 3
	.type	__ksymtab_iterate_dir, @object
	.size	__ksymtab_iterate_dir, 24
__ksymtab_iterate_dir:
 # value:
	.quad	iterate_dir
 # name:
	.quad	__kstrtab_iterate_dir
 # namespace:
	.quad	0
	.section	__ksymtab_strings,"a"
	.type	__kstrtab_iterate_dir, @object
	.size	__kstrtab_iterate_dir, 12
__kstrtab_iterate_dir:
	.string	"iterate_dir"
	.ident	"GCC: (GNU) 9.2.0"
	.section	.note.GNU-stack,"",@progbits

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="readdir.s.objdump"


fs/readdir.o:     file format elf64-alpha


Disassembly of section .text:

0000000000000000 <iterate_dir>:
   0:	00 00 bb 27 	ldah	gp,0(t12)
   4:	00 00 bd 23 	lda	gp,0(gp)
   8:	c0 ff de 23 	lda	sp,-64(sp)
   c:	1f 04 ff 47 	nop	
  10:	08 00 3e b5 	stq	s0,8(sp)
  14:	09 04 f0 47 	mov	a0,s0
  18:	18 00 7e b5 	stq	s2,24(sp)
  1c:	0b 04 f1 47 	mov	a1,s2
  20:	00 00 5e b7 	stq	ra,0(sp)
  24:	10 00 5e b5 	stq	s1,16(sp)
  28:	20 00 9e b5 	stq	s3,32(sp)
  2c:	28 00 be b5 	stq	s4,40(sp)
  30:	30 00 de b5 	stq	s5,48(sp)
  34:	38 00 fe b5 	stq	fp,56(sp)
  38:	28 00 30 a4 	ldq	t0,40(a0)
  3c:	20 00 90 a5 	ldq	s3,32(a0)
  40:	40 00 41 a4 	ldq	t1,64(t0)
  44:	52 00 40 e4 	beq	t1,190 <iterate_dir+0x190>
  48:	a0 00 ac 21 	lda	s4,160(s3)
  4c:	00 00 7d a7 	ldq	t12,0(gp)
  50:	10 04 ed 47 	mov	s4,a0
  54:	01 00 df 21 	lda	s5,1
  58:	00 40 5b 6b 	jsr	ra,(t12),5c <iterate_dir+0x5c>
  5c:	00 00 ba 27 	ldah	gp,0(ra)
  60:	00 00 bd 23 	lda	gp,0(gp)
  64:	0a 04 e0 47 	mov	v0,s1
  68:	00 00 fe 2f 	unop	
  6c:	32 00 40 f5 	bne	s1,138 <iterate_dir+0x138>
  70:	0c 00 2c a0 	ldl	t0,12(s3)
  74:	fe ff 5f 21 	lda	s1,-2
  78:	01 10 22 44 	and	t0,0x10,t0
  7c:	28 00 20 f4 	bne	t0,120 <iterate_dir+0x120>
  80:	98 00 29 a4 	ldq	t0,152(s0)
  84:	11 04 eb 47 	mov	s2,a1
  88:	10 04 e9 47 	mov	s0,a0
  8c:	08 00 2b b4 	stq	t0,8(s2)
  90:	28 00 29 a4 	ldq	t0,40(s0)
  94:	4e 00 c0 f5 	bne	s5,1d0 <iterate_dir+0x1d0>
  98:	38 00 61 a7 	ldq	t12,56(t0)
  9c:	00 40 5b 6b 	jsr	ra,(t12),a0 <iterate_dir+0xa0>
  a0:	00 00 ba 27 	ldah	gp,0(ra)
  a4:	00 00 bd 23 	lda	gp,0(gp)
  a8:	0a 04 e0 47 	mov	v0,s1
  ac:	1f 04 ff 47 	nop	
  b0:	08 00 2b a4 	ldq	t0,8(s2)
  b4:	20 00 89 a5 	ldq	s3,32(s0)
  b8:	5c 00 49 a0 	ldl	t1,92(s0)
  bc:	00 40 5f 26 	ldah	a2,16384
  c0:	98 00 29 b4 	stq	t0,152(s0)
  c4:	01 00 52 22 	lda	a2,1(a2)
  c8:	00 00 2c a0 	ldl	t0,0(s3)
  cc:	01 00 7f 21 	lda	s2,1
  d0:	82 56 43 48 	srl	t1,0x1a,t1
  d4:	10 00 e9 21 	lda	fp,16(s0)
  d8:	c3 12 20 48 	extwl	t0,0,t2
  dc:	00 f0 3f 20 	lda	t0,-4096
  e0:	01 00 23 44 	and	t0,t2,t0
  e4:	00 c0 21 20 	lda	t0,-16384(t0)
  e8:	8b 04 32 44 	cmoveq	t0,a2,s2
  ec:	40 00 40 e0 	blbc	t1,1f0 <iterate_dir+0x1f0>
  f0:	58 00 29 a0 	ldl	t0,88(s0)
  f4:	81 96 22 48 	srl	t0,0x14,t0
  f8:	00 00 fe 2f 	unop	
  fc:	08 00 20 f0 	blbs	t0,120 <iterate_dir+0x120>
 100:	00 00 7d a7 	ldq	t12,0(gp)
 104:	10 04 ef 47 	mov	fp,a0
 108:	00 40 5b 6b 	jsr	ra,(t12),10c <iterate_dir+0x10c>
 10c:	00 00 ba 27 	ldah	gp,0(ra)
 110:	00 00 bd 23 	lda	gp,0(gp)
 114:	00 00 fe 2f 	unop	
 118:	1f 04 ff 47 	nop	
 11c:	00 00 fe 2f 	unop	
 120:	10 04 ed 47 	mov	s4,a0
 124:	12 00 c0 e5 	beq	s5,170 <iterate_dir+0x170>
 128:	00 00 7d a7 	ldq	t12,0(gp)
 12c:	00 40 5b 6b 	jsr	ra,(t12),130 <iterate_dir+0x130>
 130:	00 00 ba 27 	ldah	gp,0(ra)
 134:	00 00 bd 23 	lda	gp,0(gp)
 138:	00 04 ea 47 	mov	s1,v0
 13c:	00 00 5e a7 	ldq	ra,0(sp)
 140:	08 00 3e a5 	ldq	s0,8(sp)
 144:	10 00 5e a5 	ldq	s1,16(sp)
 148:	18 00 7e a5 	ldq	s2,24(sp)
 14c:	20 00 9e a5 	ldq	s3,32(sp)
 150:	28 00 be a5 	ldq	s4,40(sp)
 154:	30 00 de a5 	ldq	s5,48(sp)
 158:	38 00 fe a5 	ldq	fp,56(sp)
 15c:	1f 04 ff 47 	nop	
 160:	40 00 de 23 	lda	sp,64(sp)
 164:	01 80 fa 6b 	ret
 168:	1f 04 ff 47 	nop	
 16c:	00 00 fe 2f 	unop	
 170:	00 00 7d a7 	ldq	t12,0(gp)
 174:	1f 04 ff 47 	nop	
 178:	00 40 5b 6b 	jsr	ra,(t12),17c <iterate_dir+0x17c>
 17c:	00 00 ba 27 	ldah	gp,0(ra)
 180:	00 00 bd 23 	lda	gp,0(gp)
 184:	ec ff ff c3 	br	138 <iterate_dir+0x138>
 188:	1f 04 ff 47 	nop	
 18c:	00 00 fe 2f 	unop	
 190:	38 00 21 a4 	ldq	t0,56(t0)
 194:	ec ff 5f 21 	lda	s1,-20
 198:	00 00 fe 2f 	unop	
 19c:	e6 ff 3f e4 	beq	t0,138 <iterate_dir+0x138>
 1a0:	a0 00 ac 21 	lda	s4,160(s3)
 1a4:	00 00 7d a7 	ldq	t12,0(gp)
 1a8:	10 04 ed 47 	mov	s4,a0
 1ac:	0e 04 ff 47 	clr	s5
 1b0:	00 40 5b 6b 	jsr	ra,(t12),1b4 <iterate_dir+0x1b4>
 1b4:	00 00 ba 27 	ldah	gp,0(ra)
 1b8:	00 00 bd 23 	lda	gp,0(gp)
 1bc:	0a 04 e0 47 	mov	v0,s1
 1c0:	a9 ff ff c3 	br	68 <iterate_dir+0x68>
 1c4:	00 00 fe 2f 	unop	
 1c8:	1f 04 ff 47 	nop	
 1cc:	00 00 fe 2f 	unop	
 1d0:	40 00 61 a7 	ldq	t12,64(t0)
 1d4:	00 40 5b 6b 	jsr	ra,(t12),1d8 <iterate_dir+0x1d8>
 1d8:	00 00 ba 27 	ldah	gp,0(ra)
 1dc:	00 00 bd 23 	lda	gp,0(gp)
 1e0:	0a 04 e0 47 	mov	v0,s1
 1e4:	b2 ff ff c3 	br	b0 <iterate_dir+0xb0>
 1e8:	1f 04 ff 47 	nop	
 1ec:	00 00 fe 2f 	unop	
 1f0:	18 00 29 a6 	ldq	a1,24(s0)
 1f4:	00 00 7d a7 	ldq	t12,0(gp)
 1f8:	12 04 eb 47 	mov	s2,a2
 1fc:	10 04 ef 47 	mov	fp,a0
 200:	00 40 5b 6b 	jsr	ra,(t12),204 <iterate_dir+0x204>
 204:	00 00 ba 27 	ldah	gp,0(ra)
 208:	00 00 bd 23 	lda	gp,0(gp)
 20c:	b8 ff 1f f4 	bne	v0,f0 <iterate_dir+0xf0>
 210:	00 00 7d a7 	ldq	t12,0(gp)
 214:	15 04 ff 47 	clr	a5
 218:	14 04 ff 47 	clr	a4
 21c:	01 00 7f 22 	lda	a3,1
 220:	12 04 ef 47 	mov	fp,a2
 224:	11 04 eb 47 	mov	s2,a1
 228:	10 04 ec 47 	mov	s3,a0
 22c:	00 40 5b 6b 	jsr	ra,(t12),230 <iterate_dir+0x230>
 230:	00 00 ba 27 	ldah	gp,0(ra)
 234:	00 00 bd 23 	lda	gp,0(gp)
 238:	ad ff ff c3 	br	f0 <iterate_dir+0xf0>
 23c:	00 00 fe 2f 	unop	

0000000000000240 <fillonedir>:
 240:	00 00 bb 27 	ldah	gp,0(t12)
 244:	00 00 bd 23 	lda	gp,0(gp)
 248:	d0 ff de 23 	lda	sp,-48(sp)
 24c:	1f 04 ff 47 	nop	
 250:	18 00 7e b5 	stq	s2,24(sp)
 254:	0b 04 f0 47 	mov	a0,s2
 258:	20 00 9e b5 	stq	s3,32(sp)
 25c:	0c 04 f2 47 	mov	a2,s3
 260:	00 00 5e b7 	stq	ra,0(sp)
 264:	08 00 3e b5 	stq	s0,8(sp)
 268:	10 00 5e b5 	stq	s1,16(sp)
 26c:	18 00 50 a1 	ldl	s1,24(a0)
 270:	3f 00 40 f5 	bne	s1,370 <fillonedir+0x130>
 274:	10 00 50 a4 	ldq	t1,16(a0)
 278:	01 00 32 20 	lda	t0,1(a2)
 27c:	01 00 7f 20 	lda	t2,1
 280:	18 00 70 b0 	stl	t2,24(a0)
 284:	12 00 22 21 	lda	s0,18(t1)
 288:	01 04 21 41 	addq	s0,t0,t0
 28c:	50 00 88 a4 	ldq	t3,80(t7)
 290:	23 05 22 40 	subq	t0,t1,t2
 294:	a5 03 e3 43 	cmpult	zero,t2,t4
 298:	03 04 43 44 	or	t1,t2,t2
 29c:	21 05 25 40 	subq	t0,t4,t0
 2a0:	01 04 23 44 	or	t0,t2,t0
 2a4:	01 00 24 44 	and	t0,t3,t0
 2a8:	2d 00 20 f4 	bne	t0,360 <fillonedir+0x120>
 2ac:	01 04 ea 47 	mov	s1,t0
 2b0:	00 00 82 b6 	stq	a4,0(t1)
 2b4:	2a 00 20 f4 	bne	t0,360 <fillonedir+0x120>
 2b8:	01 04 ea 47 	mov	s1,t0
 2bc:	08 00 62 b6 	stq	a3,8(t1)
 2c0:	27 00 20 f4 	bne	t0,360 <fillonedir+0x120>
 2c4:	00 00 fe 2f 	unop	
 2c8:	10 00 42 20 	lda	t1,16(t1)
 2cc:	01 04 ea 47 	mov	s1,t0
 2d0:	23 76 40 4a 	zapnot	a2,0x3,t2
 2d4:	01 00 a2 2c 	ldq_u	t4,1(t1)
 2d8:	00 00 82 2c 	ldq_u	t3,0(t1)
 2dc:	e7 0a 62 48 	inswh	t2,t1,t6
 2e0:	66 03 62 48 	inswl	t2,t1,t5
 2e4:	45 0a a2 48 	mskwh	t4,t1,t4
 2e8:	44 02 82 48 	mskwl	t3,t1,t3
 2ec:	05 04 a7 44 	or	t4,t6,t4
 2f0:	04 04 86 44 	or	t3,t5,t3
 2f4:	01 00 a2 3c 	stq_u	t4,1(t1)
 2f8:	00 00 82 3c 	stq_u	t3,0(t1)
 2fc:	18 00 20 f4 	bne	t0,360 <fillonedir+0x120>
 300:	00 00 7d a7 	ldq	t12,0(gp)
 304:	10 04 e9 47 	mov	s0,a0
 308:	00 40 5b 6b 	jsr	ra,(t12),30c <fillonedir+0xcc>
 30c:	00 00 ba 27 	ldah	gp,0(ra)
 310:	00 00 bd 23 	lda	gp,0(gp)
 314:	12 00 00 f4 	bne	v0,360 <fillonedir+0x120>
 318:	09 04 2c 41 	addq	s0,s3,s0
 31c:	01 04 ea 47 	mov	s1,t0
 320:	00 00 49 2c 	ldq_u	t1,0(s0)
 324:	63 01 49 49 	insbl	s1,s0,t2
 328:	42 00 49 48 	mskbl	t1,s0,t1
 32c:	02 04 43 44 	or	t1,t2,t1
 330:	00 00 49 3c 	stq_u	t1,0(s0)
 334:	0a 00 20 f4 	bne	t0,360 <fillonedir+0x120>
 338:	00 04 ea 47 	mov	s1,v0
 33c:	00 00 5e a7 	ldq	ra,0(sp)
 340:	08 00 3e a5 	ldq	s0,8(sp)
 344:	10 00 5e a5 	ldq	s1,16(sp)
 348:	18 00 7e a5 	ldq	s2,24(sp)
 34c:	20 00 9e a5 	ldq	s3,32(sp)
 350:	30 00 de 23 	lda	sp,48(sp)
 354:	01 80 fa 6b 	ret
 358:	1f 04 ff 47 	nop	
 35c:	00 00 fe 2f 	unop	
 360:	f2 ff 3f 20 	lda	t0,-14
 364:	f2 ff 5f 21 	lda	s1,-14
 368:	18 00 2b b0 	stl	t0,24(s2)
 36c:	f2 ff ff c3 	br	338 <fillonedir+0xf8>
 370:	ea ff 5f 21 	lda	s1,-22
 374:	f0 ff ff c3 	br	338 <fillonedir+0xf8>
 378:	1f 04 ff 47 	nop	
 37c:	00 00 fe 2f 	unop	

0000000000000380 <verify_dirent_name>:
 380:	00 00 bb 27 	ldah	gp,0(t12)
 384:	00 00 bd 23 	lda	gp,0(gp)
 388:	e0 ff de 23 	lda	sp,-32(sp)
 38c:	12 04 f1 47 	mov	a1,a2
 390:	00 00 5e b7 	stq	ra,0(sp)
 394:	0a 00 20 e6 	beq	a1,3c0 <verify_dirent_name+0x40>
 398:	00 00 7d a7 	ldq	t12,0(gp)
 39c:	2f 00 3f 22 	lda	a1,47
 3a0:	00 40 5b 6b 	jsr	ra,(t12),3a4 <verify_dirent_name+0x24>
 3a4:	00 00 ba 27 	ldah	gp,0(ra)
 3a8:	00 00 bd 23 	lda	gp,0(gp)
 3ac:	1c 00 00 f4 	bne	v0,420 <verify_dirent_name+0xa0>
 3b0:	00 00 5e a7 	ldq	ra,0(sp)
 3b4:	20 00 de 23 	lda	sp,32(sp)
 3b8:	01 80 fa 6b 	ret
 3bc:	00 00 fe 2f 	unop	
 3c0:	00 00 3d 24 	ldah	t0,0(gp)
 3c4:	fb ff 1f 20 	lda	v0,-5
 3c8:	00 00 41 2c 	ldq_u	t1,0(t0)
 3cc:	00 00 61 20 	lda	t2,0(t0)
 3d0:	c4 00 43 48 	extbl	t1,t2,t3
 3d4:	f6 ff 9f f4 	bne	t3,3b0 <verify_dirent_name+0x30>
 3d8:	01 00 9f 20 	lda	t3,1
 3dc:	13 04 ff 47 	clr	a3
 3e0:	42 00 43 48 	mskbl	t1,t2,t1
 3e4:	09 00 5f 22 	lda	a2,9
 3e8:	63 01 83 48 	insbl	t3,t2,t2
 3ec:	94 00 3f 22 	lda	a1,148
 3f0:	03 04 62 44 	or	t2,t1,t2
 3f4:	00 00 61 3c 	stq_u	t2,0(t0)
 3f8:	00 00 1d 26 	ldah	a0,0(gp)
 3fc:	00 00 7d a7 	ldq	t12,0(gp)
 400:	10 00 1e b4 	stq	v0,16(sp)
 404:	00 00 10 22 	lda	a0,0(a0)
 408:	00 40 5b 6b 	jsr	ra,(t12),40c <verify_dirent_name+0x8c>
 40c:	00 00 ba 27 	ldah	gp,0(ra)
 410:	00 00 bd 23 	lda	gp,0(gp)
 414:	10 00 1e a4 	ldq	v0,16(sp)
 418:	e5 ff ff c3 	br	3b0 <verify_dirent_name+0x30>
 41c:	00 00 fe 2f 	unop	
 420:	00 00 3d 24 	ldah	t0,0(gp)
 424:	fb ff 1f 20 	lda	v0,-5
 428:	00 00 41 2c 	ldq_u	t1,0(t0)
 42c:	00 00 61 20 	lda	t2,0(t0)
 430:	c4 00 43 48 	extbl	t1,t2,t3
 434:	de ff 9f f4 	bne	t3,3b0 <verify_dirent_name+0x30>
 438:	01 00 9f 20 	lda	t3,1
 43c:	13 04 ff 47 	clr	a3
 440:	42 00 43 48 	mskbl	t1,t2,t1
 444:	09 00 5f 22 	lda	a2,9
 448:	63 01 83 48 	insbl	t3,t2,t2
 44c:	96 00 3f 22 	lda	a1,150
 450:	03 04 62 44 	or	t2,t1,t2
 454:	00 00 61 3c 	stq_u	t2,0(t0)
 458:	e7 ff ff c3 	br	3f8 <verify_dirent_name+0x78>
 45c:	00 00 fe 2f 	unop	

0000000000000460 <filldir>:
 460:	00 00 bb 27 	ldah	gp,0(t12)
 464:	00 00 bd 23 	lda	gp,0(gp)
 468:	c0 ff de 23 	lda	sp,-64(sp)
 46c:	1f 04 ff 47 	nop	
 470:	08 00 3e b5 	stq	s0,8(sp)
 474:	09 04 f1 47 	mov	a1,s0
 478:	28 00 be b5 	stq	s4,40(sp)
 47c:	0d 70 43 42 	addl	a2,0x1b,s4
 480:	18 00 7e b5 	stq	s2,24(sp)
 484:	0d f1 a0 45 	andnot	s4,0x7,s4
 488:	0b 04 f0 47 	mov	a0,s2
 48c:	11 04 f2 47 	mov	a2,a1
 490:	10 04 e9 47 	mov	s0,a0
 494:	0d 00 ed 43 	sextl	s4,s4
 498:	10 00 5e b5 	stq	s1,16(sp)
 49c:	0a 04 f2 47 	mov	a2,s1
 4a0:	20 00 9e b5 	stq	s3,32(sp)
 4a4:	0c 04 f5 47 	mov	a5,s3
 4a8:	30 00 de b5 	stq	s5,48(sp)
 4ac:	0e 04 f4 47 	mov	a4,s5
 4b0:	38 00 fe b5 	stq	fp,56(sp)
 4b4:	0f 04 f3 47 	mov	a3,fp
 4b8:	00 00 5e b7 	stq	ra,0(sp)
 4bc:	00 00 7d a7 	ldq	t12,0(gp)
 4c0:	00 40 5b 6b 	jsr	ra,(t12),4c4 <filldir+0x64>
 4c4:	00 00 ba 27 	ldah	gp,0(ra)
 4c8:	00 00 bd 23 	lda	gp,0(gp)
 4cc:	9c 00 00 f4 	bne	v0,740 <filldir+0x2e0>
 4d0:	ea ff 3f 20 	lda	t0,-22
 4d4:	20 00 ab a0 	ldl	t4,32(s2)
 4d8:	24 00 2b b0 	stl	t0,36(s2)
 4dc:	1f 04 ff 47 	nop	
 4e0:	a1 09 ad 40 	cmplt	t4,s4,t0
 4e4:	9c 00 20 f4 	bne	t0,758 <filldir+0x2f8>
 4e8:	18 00 4b a4 	ldq	t1,24(s2)
 4ec:	50 00 40 e4 	beq	t1,630 <filldir+0x1d0>
 4f0:	40 00 28 a4 	ldq	t0,64(t7)
 4f4:	08 00 21 a4 	ldq	t0,8(t0)
 4f8:	48 00 21 a0 	ldl	t0,72(t0)
 4fc:	01 90 20 44 	and	t0,0x4,t0
 500:	a1 03 e1 43 	cmpult	zero,t0,t0
 504:	92 00 20 f4 	bne	t0,750 <filldir+0x2f0>
 508:	17 00 22 20 	lda	t0,23(t1)
 50c:	50 00 68 a4 	ldq	t2,80(t7)
 510:	01 04 22 44 	or	t0,t1,t0
 514:	01 14 23 44 	or	t0,0x18,t0
 518:	01 00 23 44 	and	t0,t2,t0
 51c:	36 00 20 f4 	bne	t0,5f8 <filldir+0x198>
 520:	01 04 e0 47 	mov	v0,t0
 524:	08 00 e2 b5 	stq	fp,8(t1)
 528:	33 00 20 f4 	bne	t0,5f8 <filldir+0x198>
 52c:	00 00 fe 2f 	unop	
 530:	10 00 cb a4 	ldq	t5,16(s2)
 534:	01 04 ff 47 	clr	t0
 538:	00 00 c6 b5 	stq	s5,0(t5)
 53c:	2e 00 20 f4 	bne	t0,5f8 <filldir+0x198>
 540:	23 76 a0 49 	zapnot	s4,0x3,t2
 544:	10 00 46 20 	lda	t1,16(t5)
 548:	01 00 e2 2c 	ldq_u	t6,1(t1)
 54c:	00 00 82 2c 	ldq_u	t3,0(t1)
 550:	f7 0a 62 48 	inswh	t2,t1,t9
 554:	76 03 62 48 	inswl	t2,t1,t8
 558:	47 0a e2 48 	mskwh	t6,t1,t6
 55c:	44 02 82 48 	mskwl	t3,t1,t3
 560:	07 04 f7 44 	or	t6,t9,t6
 564:	04 04 96 44 	or	t3,t8,t3
 568:	01 00 e2 3c 	stq_u	t6,1(t1)
 56c:	00 00 82 3c 	stq_u	t3,0(t1)
 570:	21 00 20 f4 	bne	t0,5f8 <filldir+0x198>
 574:	00 00 fe 2f 	unop	
 578:	2c 17 87 49 	sll	s3,0x38,s3
 57c:	ff ff 4d 20 	lda	t1,-1(s4)
 580:	8c 17 87 49 	sra	s3,0x38,s3
 584:	02 04 c2 40 	addq	t5,t1,t1
 588:	00 00 62 2c 	ldq_u	t2,0(t1)
 58c:	64 01 82 49 	insbl	s3,t1,t3
 590:	43 00 62 48 	mskbl	t2,t1,t2
 594:	03 04 64 44 	or	t2,t3,t2
 598:	00 00 62 3c 	stq_u	t2,0(t1)
 59c:	16 00 20 f4 	bne	t0,5f8 <filldir+0x198>
 5a0:	12 04 ea 47 	mov	s1,a2
 5a4:	12 00 46 20 	lda	t1,18(t5)
 5a8:	a1 f7 40 41 	cmpule	s1,0x7,t0
 5ac:	24 00 20 f4 	bne	t0,640 <filldir+0x1e0>
 5b0:	07 04 ff 47 	clr	t6
 5b4:	06 00 e0 c3 	br	5d0 <filldir+0x170>
 5b8:	1f 04 ff 47 	nop	
 5bc:	00 00 fe 2f 	unop	
 5c0:	08 00 42 20 	lda	t1,8(t1)
 5c4:	08 00 29 21 	lda	s0,8(s0)
 5c8:	a1 f7 40 42 	cmpule	a2,0x7,t0
 5cc:	1c 00 20 f4 	bne	t0,640 <filldir+0x1e0>
 5d0:	00 00 29 2c 	ldq_u	t0,0(s0)
 5d4:	07 00 89 2c 	ldq_u	t3,7(s0)
 5d8:	03 04 e7 47 	mov	t6,t2
 5dc:	c1 06 29 48 	extql	t0,s0,t0
 5e0:	44 0f 89 48 	extqh	t3,s0,t3
 5e4:	01 04 24 44 	or	t0,t3,t0
 5e8:	00 00 22 b4 	stq	t0,0(t1)
 5ec:	00 00 fe 2f 	unop	
 5f0:	f8 ff 52 22 	lda	a2,-8(a2)
 5f4:	f2 ff 7f e4 	beq	t2,5c0 <filldir+0x160>
 5f8:	f2 ff 3f 20 	lda	t0,-14
 5fc:	f2 ff 1f 20 	lda	v0,-14
 600:	24 00 2b b0 	stl	t0,36(s2)
 604:	1f 04 ff 47 	nop	
 608:	00 00 5e a7 	ldq	ra,0(sp)
 60c:	08 00 3e a5 	ldq	s0,8(sp)
 610:	10 00 5e a5 	ldq	s1,16(sp)
 614:	18 00 7e a5 	ldq	s2,24(sp)
 618:	20 00 9e a5 	ldq	s3,32(sp)
 61c:	28 00 be a5 	ldq	s4,40(sp)
 620:	30 00 de a5 	ldq	s5,48(sp)
 624:	38 00 fe a5 	ldq	fp,56(sp)
 628:	40 00 de 23 	lda	sp,64(sp)
 62c:	01 80 fa 6b 	ret
 630:	50 00 28 a4 	ldq	t0,80(t7)
 634:	01 f0 23 44 	and	t0,0x1f,t0
 638:	bd ff 3f e4 	beq	t0,530 <filldir+0xd0>
 63c:	ee ff ff c3 	br	5f8 <filldir+0x198>
 640:	a1 77 40 42 	cmpule	a2,0x3,t0
 644:	0c 00 20 f4 	bne	t0,678 <filldir+0x218>
 648:	00 00 29 2c 	ldq_u	t0,0(s0)
 64c:	03 00 89 2c 	ldq_u	t3,3(s0)
 650:	03 04 ff 47 	clr	t2
 654:	c1 04 29 48 	extll	t0,s0,t0
 658:	44 0d 89 48 	extlh	t3,s0,t3
 65c:	01 04 24 44 	or	t0,t3,t0
 660:	00 00 22 b0 	stl	t0,0(t1)
 664:	e4 ff 7f f4 	bne	t2,5f8 <filldir+0x198>
 668:	04 00 42 20 	lda	t1,4(t1)
 66c:	04 00 29 21 	lda	s0,4(s0)
 670:	fc ff 52 22 	lda	a2,-4(a2)
 674:	1f 04 ff 47 	nop	
 678:	a1 37 40 42 	cmpule	a2,0x1,t0
 67c:	15 00 20 f4 	bne	t0,6d4 <filldir+0x274>
 680:	00 00 29 2c 	ldq_u	t0,0(s0)
 684:	01 00 89 2c 	ldq_u	t3,1(s0)
 688:	03 04 ff 47 	clr	t2
 68c:	c1 02 29 48 	extwl	t0,s0,t0
 690:	44 0b 89 48 	extwh	t3,s0,t3
 694:	01 04 24 44 	or	t0,t3,t0
 698:	21 76 20 48 	zapnot	t0,0x3,t0
 69c:	01 00 e2 2c 	ldq_u	t6,1(t1)
 6a0:	00 00 82 2c 	ldq_u	t3,0(t1)
 6a4:	f7 0a 22 48 	inswh	t0,t1,t9
 6a8:	76 03 22 48 	inswl	t0,t1,t8
 6ac:	47 0a e2 48 	mskwh	t6,t1,t6
 6b0:	44 02 82 48 	mskwl	t3,t1,t3
 6b4:	07 04 f7 44 	or	t6,t9,t6
 6b8:	04 04 96 44 	or	t3,t8,t3
 6bc:	01 00 e2 3c 	stq_u	t6,1(t1)
 6c0:	00 00 82 3c 	stq_u	t3,0(t1)
 6c4:	cc ff 7f f4 	bne	t2,5f8 <filldir+0x198>
 6c8:	02 00 42 20 	lda	t1,2(t1)
 6cc:	02 00 29 21 	lda	s0,2(s0)
 6d0:	fe ff 52 22 	lda	a2,-2(a2)
 6d4:	0a 00 40 e6 	beq	a2,700 <filldir+0x2a0>
 6d8:	00 00 69 2c 	ldq_u	t2,0(s0)
 6dc:	01 04 ff 47 	clr	t0
 6e0:	c9 00 69 48 	extbl	t2,s0,s0
 6e4:	00 00 62 2c 	ldq_u	t2,0(t1)
 6e8:	64 01 22 49 	insbl	s0,t1,t3
 6ec:	43 00 62 48 	mskbl	t2,t1,t2
 6f0:	03 04 64 44 	or	t2,t3,t2
 6f4:	00 00 62 3c 	stq_u	t2,0(t1)
 6f8:	bf ff 3f f4 	bne	t0,5f8 <filldir+0x198>
 6fc:	01 00 42 20 	lda	t1,1(t1)
 700:	01 04 ff 47 	clr	t0
 704:	00 00 62 2c 	ldq_u	t2,0(t1)
 708:	64 01 22 48 	insbl	t0,t1,t3
 70c:	43 00 62 48 	mskbl	t2,t1,t2
 710:	03 04 64 44 	or	t2,t3,t2
 714:	00 00 62 3c 	stq_u	t2,0(t1)
 718:	b7 ff 3f f4 	bne	t0,5f8 <filldir+0x198>
 71c:	00 00 fe 2f 	unop	
 720:	01 04 cd 40 	addq	t5,s4,t0
 724:	25 01 ad 40 	subl	t4,s4,t4
 728:	18 00 cb b4 	stq	t5,24(s2)
 72c:	10 00 2b b4 	stq	t0,16(s2)
 730:	20 00 ab b0 	stl	t4,32(s2)
 734:	b4 ff ff c3 	br	608 <filldir+0x1a8>
 738:	1f 04 ff 47 	nop	
 73c:	00 00 fe 2f 	unop	
 740:	24 00 0b b0 	stl	v0,36(s2)
 744:	b0 ff ff c3 	br	608 <filldir+0x1a8>
 748:	1f 04 ff 47 	nop	
 74c:	00 00 fe 2f 	unop	
 750:	fc ff 1f 20 	lda	v0,-4
 754:	ac ff ff c3 	br	608 <filldir+0x1a8>
 758:	ea ff 1f 20 	lda	v0,-22
 75c:	aa ff ff c3 	br	608 <filldir+0x1a8>

0000000000000760 <filldir64>:
 760:	00 00 bb 27 	ldah	gp,0(t12)
 764:	00 00 bd 23 	lda	gp,0(gp)
 768:	c0 ff de 23 	lda	sp,-64(sp)
 76c:	1f 04 ff 47 	nop	
 770:	08 00 3e b5 	stq	s0,8(sp)
 774:	09 04 f1 47 	mov	a1,s0
 778:	20 00 9e b5 	stq	s3,32(sp)
 77c:	0c 70 43 42 	addl	a2,0x1b,s3
 780:	18 00 7e b5 	stq	s2,24(sp)
 784:	0c f1 80 45 	andnot	s3,0x7,s3
 788:	0b 04 f0 47 	mov	a0,s2
 78c:	11 04 f2 47 	mov	a2,a1
 790:	10 04 e9 47 	mov	s0,a0
 794:	0c 00 ec 43 	sextl	s3,s3
 798:	10 00 5e b5 	stq	s1,16(sp)
 79c:	0a 04 f2 47 	mov	a2,s1
 7a0:	28 00 be b5 	stq	s4,40(sp)
 7a4:	0d 04 f5 47 	mov	a5,s4
 7a8:	30 00 de b5 	stq	s5,48(sp)
 7ac:	0e 04 f4 47 	mov	a4,s5
 7b0:	38 00 fe b5 	stq	fp,56(sp)
 7b4:	0f 04 f3 47 	mov	a3,fp
 7b8:	00 00 5e b7 	stq	ra,0(sp)
 7bc:	00 00 7d a7 	ldq	t12,0(gp)
 7c0:	00 40 5b 6b 	jsr	ra,(t12),7c4 <filldir64+0x64>
 7c4:	00 00 ba 27 	ldah	gp,0(ra)
 7c8:	00 00 bd 23 	lda	gp,0(gp)
 7cc:	98 00 00 f4 	bne	v0,a30 <filldir64+0x2d0>
 7d0:	ea ff 3f 20 	lda	t0,-22
 7d4:	20 00 ab a0 	ldl	t4,32(s2)
 7d8:	24 00 2b b0 	stl	t0,36(s2)
 7dc:	1f 04 ff 47 	nop	
 7e0:	a1 09 ac 40 	cmplt	t4,s3,t0
 7e4:	98 00 20 f4 	bne	t0,a48 <filldir64+0x2e8>
 7e8:	18 00 4b a4 	ldq	t1,24(s2)
 7ec:	4c 00 40 e4 	beq	t1,920 <filldir64+0x1c0>
 7f0:	40 00 28 a4 	ldq	t0,64(t7)
 7f4:	08 00 21 a4 	ldq	t0,8(t0)
 7f8:	48 00 21 a0 	ldl	t0,72(t0)
 7fc:	01 90 20 44 	and	t0,0x4,t0
 800:	a1 03 e1 43 	cmpult	zero,t0,t0
 804:	8e 00 20 f4 	bne	t0,a40 <filldir64+0x2e0>
 808:	17 00 22 20 	lda	t0,23(t1)
 80c:	50 00 68 a4 	ldq	t2,80(t7)
 810:	01 04 22 44 	or	t0,t1,t0
 814:	01 14 23 44 	or	t0,0x18,t0
 818:	01 00 23 44 	and	t0,t2,t0
 81c:	32 00 20 f4 	bne	t0,8e8 <filldir64+0x188>
 820:	01 04 e0 47 	mov	v0,t0
 824:	08 00 e2 b5 	stq	fp,8(t1)
 828:	2f 00 20 f4 	bne	t0,8e8 <filldir64+0x188>
 82c:	00 00 fe 2f 	unop	
 830:	10 00 cb a4 	ldq	t5,16(s2)
 834:	01 04 ff 47 	clr	t0
 838:	00 00 c6 b5 	stq	s5,0(t5)
 83c:	2a 00 20 f4 	bne	t0,8e8 <filldir64+0x188>
 840:	23 76 80 49 	zapnot	s3,0x3,t2
 844:	10 00 46 20 	lda	t1,16(t5)
 848:	01 00 e2 2c 	ldq_u	t6,1(t1)
 84c:	00 00 82 2c 	ldq_u	t3,0(t1)
 850:	f7 0a 62 48 	inswh	t2,t1,t9
 854:	76 03 62 48 	inswl	t2,t1,t8
 858:	47 0a e2 48 	mskwh	t6,t1,t6
 85c:	44 02 82 48 	mskwl	t3,t1,t3
 860:	07 04 f7 44 	or	t6,t9,t6
 864:	04 04 96 44 	or	t3,t8,t3
 868:	01 00 e2 3c 	stq_u	t6,1(t1)
 86c:	00 00 82 3c 	stq_u	t3,0(t1)
 870:	1d 00 20 f4 	bne	t0,8e8 <filldir64+0x188>
 874:	00 00 fe 2f 	unop	
 878:	0d f0 bf 45 	and	s4,0xff,s4
 87c:	12 00 46 20 	lda	t1,18(t5)
 880:	00 00 62 2c 	ldq_u	t2,0(t1)
 884:	64 01 a2 49 	insbl	s4,t1,t3
 888:	43 00 62 48 	mskbl	t2,t1,t2
 88c:	03 04 64 44 	or	t2,t3,t2
 890:	00 00 62 3c 	stq_u	t2,0(t1)
 894:	14 00 20 f4 	bne	t0,8e8 <filldir64+0x188>
 898:	12 04 ea 47 	mov	s1,a2
 89c:	13 00 46 20 	lda	t1,19(t5)
 8a0:	a1 f7 40 41 	cmpule	s1,0x7,t0
 8a4:	22 00 20 f4 	bne	t0,930 <filldir64+0x1d0>
 8a8:	07 04 ff 47 	clr	t6
 8ac:	04 00 e0 c3 	br	8c0 <filldir64+0x160>
 8b0:	08 00 42 20 	lda	t1,8(t1)
 8b4:	08 00 29 21 	lda	s0,8(s0)
 8b8:	a1 f7 40 42 	cmpule	a2,0x7,t0
 8bc:	1c 00 20 f4 	bne	t0,930 <filldir64+0x1d0>
 8c0:	00 00 29 2c 	ldq_u	t0,0(s0)
 8c4:	07 00 89 2c 	ldq_u	t3,7(s0)
 8c8:	03 04 e7 47 	mov	t6,t2
 8cc:	c1 06 29 48 	extql	t0,s0,t0
 8d0:	44 0f 89 48 	extqh	t3,s0,t3
 8d4:	01 04 24 44 	or	t0,t3,t0
 8d8:	00 00 22 b4 	stq	t0,0(t1)
 8dc:	00 00 fe 2f 	unop	
 8e0:	f8 ff 52 22 	lda	a2,-8(a2)
 8e4:	f2 ff 7f e4 	beq	t2,8b0 <filldir64+0x150>
 8e8:	f2 ff 3f 20 	lda	t0,-14
 8ec:	f2 ff 1f 20 	lda	v0,-14
 8f0:	24 00 2b b0 	stl	t0,36(s2)
 8f4:	1f 04 ff 47 	nop	
 8f8:	00 00 5e a7 	ldq	ra,0(sp)
 8fc:	08 00 3e a5 	ldq	s0,8(sp)
 900:	10 00 5e a5 	ldq	s1,16(sp)
 904:	18 00 7e a5 	ldq	s2,24(sp)
 908:	20 00 9e a5 	ldq	s3,32(sp)
 90c:	28 00 be a5 	ldq	s4,40(sp)
 910:	30 00 de a5 	ldq	s5,48(sp)
 914:	38 00 fe a5 	ldq	fp,56(sp)
 918:	40 00 de 23 	lda	sp,64(sp)
 91c:	01 80 fa 6b 	ret
 920:	50 00 28 a4 	ldq	t0,80(t7)
 924:	01 f0 23 44 	and	t0,0x1f,t0
 928:	c1 ff 3f e4 	beq	t0,830 <filldir64+0xd0>
 92c:	ee ff ff c3 	br	8e8 <filldir64+0x188>
 930:	a1 77 40 42 	cmpule	a2,0x3,t0
 934:	0c 00 20 f4 	bne	t0,968 <filldir64+0x208>
 938:	00 00 29 2c 	ldq_u	t0,0(s0)
 93c:	03 00 89 2c 	ldq_u	t3,3(s0)
 940:	03 04 ff 47 	clr	t2
 944:	c1 04 29 48 	extll	t0,s0,t0
 948:	44 0d 89 48 	extlh	t3,s0,t3
 94c:	01 04 24 44 	or	t0,t3,t0
 950:	00 00 22 b0 	stl	t0,0(t1)
 954:	e4 ff 7f f4 	bne	t2,8e8 <filldir64+0x188>
 958:	04 00 42 20 	lda	t1,4(t1)
 95c:	04 00 29 21 	lda	s0,4(s0)
 960:	fc ff 52 22 	lda	a2,-4(a2)
 964:	1f 04 ff 47 	nop	
 968:	a1 37 40 42 	cmpule	a2,0x1,t0
 96c:	15 00 20 f4 	bne	t0,9c4 <filldir64+0x264>
 970:	00 00 29 2c 	ldq_u	t0,0(s0)
 974:	01 00 89 2c 	ldq_u	t3,1(s0)
 978:	03 04 ff 47 	clr	t2
 97c:	c1 02 29 48 	extwl	t0,s0,t0
 980:	44 0b 89 48 	extwh	t3,s0,t3
 984:	01 04 24 44 	or	t0,t3,t0
 988:	21 76 20 48 	zapnot	t0,0x3,t0
 98c:	01 00 e2 2c 	ldq_u	t6,1(t1)
 990:	00 00 82 2c 	ldq_u	t3,0(t1)
 994:	f7 0a 22 48 	inswh	t0,t1,t9
 998:	76 03 22 48 	inswl	t0,t1,t8
 99c:	47 0a e2 48 	mskwh	t6,t1,t6
 9a0:	44 02 82 48 	mskwl	t3,t1,t3
 9a4:	07 04 f7 44 	or	t6,t9,t6
 9a8:	04 04 96 44 	or	t3,t8,t3
 9ac:	01 00 e2 3c 	stq_u	t6,1(t1)
 9b0:	00 00 82 3c 	stq_u	t3,0(t1)
 9b4:	cc ff 7f f4 	bne	t2,8e8 <filldir64+0x188>
 9b8:	02 00 42 20 	lda	t1,2(t1)
 9bc:	02 00 29 21 	lda	s0,2(s0)
 9c0:	fe ff 52 22 	lda	a2,-2(a2)
 9c4:	0a 00 40 e6 	beq	a2,9f0 <filldir64+0x290>
 9c8:	00 00 69 2c 	ldq_u	t2,0(s0)
 9cc:	01 04 ff 47 	clr	t0
 9d0:	c9 00 69 48 	extbl	t2,s0,s0
 9d4:	00 00 62 2c 	ldq_u	t2,0(t1)
 9d8:	64 01 22 49 	insbl	s0,t1,t3
 9dc:	43 00 62 48 	mskbl	t2,t1,t2
 9e0:	03 04 64 44 	or	t2,t3,t2
 9e4:	00 00 62 3c 	stq_u	t2,0(t1)
 9e8:	bf ff 3f f4 	bne	t0,8e8 <filldir64+0x188>
 9ec:	01 00 42 20 	lda	t1,1(t1)
 9f0:	01 04 ff 47 	clr	t0
 9f4:	00 00 62 2c 	ldq_u	t2,0(t1)
 9f8:	64 01 22 48 	insbl	t0,t1,t3
 9fc:	43 00 62 48 	mskbl	t2,t1,t2
 a00:	03 04 64 44 	or	t2,t3,t2
 a04:	00 00 62 3c 	stq_u	t2,0(t1)
 a08:	b7 ff 3f f4 	bne	t0,8e8 <filldir64+0x188>
 a0c:	00 00 fe 2f 	unop	
 a10:	01 04 cc 40 	addq	t5,s3,t0
 a14:	25 01 ac 40 	subl	t4,s3,t4
 a18:	18 00 cb b4 	stq	t5,24(s2)
 a1c:	10 00 2b b4 	stq	t0,16(s2)
 a20:	20 00 ab b0 	stl	t4,32(s2)
 a24:	b4 ff ff c3 	br	8f8 <filldir64+0x198>
 a28:	1f 04 ff 47 	nop	
 a2c:	00 00 fe 2f 	unop	
 a30:	24 00 0b b0 	stl	v0,36(s2)
 a34:	b0 ff ff c3 	br	8f8 <filldir64+0x198>
 a38:	1f 04 ff 47 	nop	
 a3c:	00 00 fe 2f 	unop	
 a40:	fc ff 1f 20 	lda	v0,-4
 a44:	ac ff ff c3 	br	8f8 <filldir64+0x198>
 a48:	ea ff 1f 20 	lda	v0,-22
 a4c:	aa ff ff c3 	br	8f8 <filldir64+0x198>

0000000000000a50 <__se_sys_old_readdir>:
 a50:	00 00 bb 27 	ldah	gp,0(t12)
 a54:	00 00 bd 23 	lda	gp,0(gp)
 a58:	c0 ff de 23 	lda	sp,-64(sp)
 a5c:	00 00 7d a7 	ldq	t12,0(gp)
 a60:	08 00 3e b5 	stq	s0,8(sp)
 a64:	10 00 f0 43 	sextl	a0,a0
 a68:	10 00 5e b5 	stq	s1,16(sp)
 a6c:	0a 04 f1 47 	mov	a1,s1
 a70:	18 00 7e b5 	stq	s2,24(sp)
 a74:	00 00 5e b7 	stq	ra,0(sp)
 a78:	00 40 5b 6b 	jsr	ra,(t12),a7c <__se_sys_old_readdir+0x2c>
 a7c:	00 00 ba 27 	ldah	gp,0(ra)
 a80:	28 00 fe b7 	stq	zero,40(sp)
 a84:	00 00 bd 23 	lda	gp,0(gp)
 a88:	0b 71 00 44 	andnot	v0,0x3,s2
 a8c:	00 00 fe 2f 	unop	
 a90:	00 00 3d 24 	ldah	t0,0(gp)
 a94:	09 00 e0 43 	sextl	v0,s0
 a98:	00 00 21 20 	lda	t0,0(t0)
 a9c:	f7 ff 1f 20 	lda	v0,-9
 aa0:	38 00 fe b7 	stq	zero,56(sp)
 aa4:	20 00 3e b4 	stq	t0,32(sp)
 aa8:	30 00 5e b5 	stq	s1,48(sp)
 aac:	0d 00 60 e5 	beq	s2,ae4 <__se_sys_old_readdir+0x94>
 ab0:	20 00 3e 22 	lda	a1,32(sp)
 ab4:	10 04 eb 47 	mov	s2,a0
 ab8:	00 00 7d a7 	ldq	t12,0(gp)
 abc:	00 40 5b 6b 	jsr	ra,(t12),ac0 <__se_sys_old_readdir+0x70>
 ac0:	00 00 ba 27 	ldah	gp,0(ra)
 ac4:	00 00 bd 23 	lda	gp,0(gp)
 ac8:	0a 04 e0 47 	mov	v0,s1
 acc:	38 00 1e a0 	ldl	v0,56(sp)
 ad0:	01 50 20 45 	and	s0,0x2,t0
 ad4:	ca 04 00 44 	cmovne	v0,v0,s1
 ad8:	11 00 20 f4 	bne	t0,b20 <__se_sys_old_readdir+0xd0>
 adc:	08 00 20 f1 	blbs	s0,b00 <__se_sys_old_readdir+0xb0>
 ae0:	00 04 ea 47 	mov	s1,v0
 ae4:	00 00 5e a7 	ldq	ra,0(sp)
 ae8:	08 00 3e a5 	ldq	s0,8(sp)
 aec:	1f 04 ff 47 	nop	
 af0:	10 00 5e a5 	ldq	s1,16(sp)
 af4:	18 00 7e a5 	ldq	s2,24(sp)
 af8:	40 00 de 23 	lda	sp,64(sp)
 afc:	01 80 fa 6b 	ret
 b00:	00 00 7d a7 	ldq	t12,0(gp)
 b04:	10 04 eb 47 	mov	s2,a0
 b08:	00 40 5b 6b 	jsr	ra,(t12),b0c <__se_sys_old_readdir+0xbc>
 b0c:	00 00 ba 27 	ldah	gp,0(ra)
 b10:	00 00 bd 23 	lda	gp,0(gp)
 b14:	f2 ff ff c3 	br	ae0 <__se_sys_old_readdir+0x90>
 b18:	1f 04 ff 47 	nop	
 b1c:	00 00 fe 2f 	unop	
 b20:	00 00 7d a7 	ldq	t12,0(gp)
 b24:	10 04 eb 47 	mov	s2,a0
 b28:	00 40 5b 6b 	jsr	ra,(t12),b2c <__se_sys_old_readdir+0xdc>
 b2c:	00 00 ba 27 	ldah	gp,0(ra)
 b30:	00 00 bd 23 	lda	gp,0(gp)
 b34:	ea ff 3f e1 	blbc	s0,ae0 <__se_sys_old_readdir+0x90>
 b38:	f1 ff ff c3 	br	b00 <__se_sys_old_readdir+0xb0>
 b3c:	00 00 fe 2f 	unop	

0000000000000b40 <__se_sys_getdents>:
 b40:	00 00 bb 27 	ldah	gp,0(t12)
 b44:	00 00 bd 23 	lda	gp,0(gp)
 b48:	22 f6 41 4a 	zapnot	a2,0xf,t1
 b4c:	a0 ff de 23 	lda	sp,-96(sp)
 b50:	a3 03 e2 43 	cmpult	zero,t1,t2
 b54:	01 04 22 42 	addq	a1,t1,t0
 b58:	21 05 23 40 	subq	t0,t2,t0
 b5c:	02 04 22 46 	or	a1,t1,t1
 b60:	10 00 5e b5 	stq	s1,16(sp)
 b64:	01 04 22 44 	or	t0,t1,t0
 b68:	18 00 7e b5 	stq	s2,24(sp)
 b6c:	00 00 5d 24 	ldah	t1,0(gp)
 b70:	00 00 5e b7 	stq	ra,0(sp)
 b74:	00 00 42 20 	lda	t1,0(t1)
 b78:	08 00 3e b5 	stq	s0,8(sp)
 b7c:	0a 04 f2 47 	mov	a2,s1
 b80:	20 00 9e b5 	stq	s3,32(sp)
 b84:	10 00 f0 43 	sextl	a0,a0
 b88:	50 00 fe b7 	stq	zero,80(sp)
 b8c:	f2 ff 7f 21 	lda	s2,-14
 b90:	50 00 68 a4 	ldq	t2,80(t7)
 b94:	38 00 fe b7 	stq	zero,56(sp)
 b98:	48 00 fe b7 	stq	zero,72(sp)
 b9c:	01 00 23 44 	and	t0,t2,t0
 ba0:	30 00 5e b4 	stq	t1,48(sp)
 ba4:	40 00 3e b6 	stq	a1,64(sp)
 ba8:	50 00 5e b2 	stl	a2,80(sp)
 bac:	22 00 20 f4 	bne	t0,c38 <__se_sys_getdents+0xf8>
 bb0:	00 00 7d a7 	ldq	t12,0(gp)
 bb4:	1f 04 ff 47 	nop	
 bb8:	00 40 5b 6b 	jsr	ra,(t12),bbc <__se_sys_getdents+0x7c>
 bbc:	00 00 ba 27 	ldah	gp,0(ra)
 bc0:	00 00 bd 23 	lda	gp,0(gp)
 bc4:	0c 71 00 44 	andnot	v0,0x3,s3
 bc8:	09 00 e0 43 	sextl	v0,s0
 bcc:	41 00 80 e5 	beq	s3,cd4 <__se_sys_getdents+0x194>
 bd0:	30 00 3e 22 	lda	a1,48(sp)
 bd4:	10 04 ec 47 	mov	s3,a0
 bd8:	00 00 7d a7 	ldq	t12,0(gp)
 bdc:	00 40 5b 6b 	jsr	ra,(t12),be0 <__se_sys_getdents+0xa0>
 be0:	00 00 ba 27 	ldah	gp,0(ra)
 be4:	00 00 bd 23 	lda	gp,0(gp)
 be8:	54 00 3e a0 	ldl	t0,84(sp)
 bec:	48 00 7e a4 	ldq	t2,72(sp)
 bf0:	c0 08 01 44 	cmovge	v0,t0,v0
 bf4:	2e 00 60 e4 	beq	t2,cb0 <__se_sys_getdents+0x170>
 bf8:	0f 00 43 20 	lda	t1,15(t2)
 bfc:	08 00 23 20 	lda	t0,8(t2)
 c00:	01 04 41 44 	or	t1,t0,t0
 c04:	50 00 48 a4 	ldq	t1,80(t7)
 c08:	01 14 21 44 	or	t0,0x8,t0
 c0c:	1f 04 ff 47 	nop	
 c10:	01 00 22 44 	and	t0,t1,t0
 c14:	04 00 20 f4 	bne	t0,c28 <__se_sys_getdents+0xe8>
 c18:	38 00 5e a4 	ldq	t1,56(sp)
 c1c:	08 00 43 b4 	stq	t1,8(t2)
 c20:	27 00 20 e4 	beq	t0,cc0 <__se_sys_getdents+0x180>
 c24:	00 00 fe 2f 	unop	
 c28:	01 50 20 45 	and	s0,0x2,t0
 c2c:	0c 00 20 f4 	bne	t0,c60 <__se_sys_getdents+0x120>
 c30:	1f 04 ff 47 	nop	
 c34:	10 00 20 f1 	blbs	s0,c78 <__se_sys_getdents+0x138>
 c38:	00 04 eb 47 	mov	s2,v0
 c3c:	00 00 5e a7 	ldq	ra,0(sp)
 c40:	08 00 3e a5 	ldq	s0,8(sp)
 c44:	10 00 5e a5 	ldq	s1,16(sp)
 c48:	18 00 7e a5 	ldq	s2,24(sp)
 c4c:	20 00 9e a5 	ldq	s3,32(sp)
 c50:	60 00 de 23 	lda	sp,96(sp)
 c54:	01 80 fa 6b 	ret
 c58:	1f 04 ff 47 	nop	
 c5c:	00 00 fe 2f 	unop	
 c60:	00 00 7d a7 	ldq	t12,0(gp)
 c64:	10 04 ec 47 	mov	s3,a0
 c68:	00 40 5b 6b 	jsr	ra,(t12),c6c <__se_sys_getdents+0x12c>
 c6c:	00 00 ba 27 	ldah	gp,0(ra)
 c70:	00 00 bd 23 	lda	gp,0(gp)
 c74:	f0 ff 3f e1 	blbc	s0,c38 <__se_sys_getdents+0xf8>
 c78:	00 00 7d a7 	ldq	t12,0(gp)
 c7c:	10 04 ec 47 	mov	s3,a0
 c80:	00 40 5b 6b 	jsr	ra,(t12),c84 <__se_sys_getdents+0x144>
 c84:	00 00 ba 27 	ldah	gp,0(ra)
 c88:	08 00 3e a5 	ldq	s0,8(sp)
 c8c:	1f 04 ff 47 	nop	
 c90:	00 04 eb 47 	mov	s2,v0
 c94:	00 00 5e a7 	ldq	ra,0(sp)
 c98:	10 00 5e a5 	ldq	s1,16(sp)
 c9c:	18 00 7e a5 	ldq	s2,24(sp)
 ca0:	20 00 9e a5 	ldq	s3,32(sp)
 ca4:	00 00 bd 23 	lda	gp,0(gp)
 ca8:	60 00 de 23 	lda	sp,96(sp)
 cac:	01 80 fa 6b 	ret
 cb0:	0b 04 e0 47 	mov	v0,s2
 cb4:	01 50 20 45 	and	s0,0x2,t0
 cb8:	dd ff 3f e4 	beq	t0,c30 <__se_sys_getdents+0xf0>
 cbc:	e8 ff ff c3 	br	c60 <__se_sys_getdents+0x120>
 cc0:	50 00 7e a1 	ldl	s2,80(sp)
 cc4:	01 50 20 45 	and	s0,0x2,t0
 cc8:	2b 01 4b 41 	subl	s1,s2,s2
 ccc:	d8 ff 3f e4 	beq	t0,c30 <__se_sys_getdents+0xf0>
 cd0:	e3 ff ff c3 	br	c60 <__se_sys_getdents+0x120>
 cd4:	f7 ff 7f 21 	lda	s2,-9
 cd8:	d7 ff ff c3 	br	c38 <__se_sys_getdents+0xf8>
 cdc:	00 00 fe 2f 	unop	

0000000000000ce0 <ksys_getdents64>:
 ce0:	00 00 bb 27 	ldah	gp,0(t12)
 ce4:	00 00 bd 23 	lda	gp,0(gp)
 ce8:	21 f6 41 4a 	zapnot	a2,0xf,t0
 cec:	a0 ff de 23 	lda	sp,-96(sp)
 cf0:	08 00 3e b5 	stq	s0,8(sp)
 cf4:	a2 03 e1 43 	cmpult	zero,t0,t1
 cf8:	10 00 5e b5 	stq	s1,16(sp)
 cfc:	09 04 21 42 	addq	a1,t0,s0
 d00:	29 05 22 41 	subq	s0,t1,s0
 d04:	01 04 21 46 	or	a1,t0,t0
 d08:	20 00 9e b5 	stq	s3,32(sp)
 d0c:	09 04 21 45 	or	s0,t0,s0
 d10:	00 00 5e b7 	stq	ra,0(sp)
 d14:	00 00 3d 24 	ldah	t0,0(gp)
 d18:	18 00 7e b5 	stq	s2,24(sp)
 d1c:	00 00 21 20 	lda	t0,0(t0)
 d20:	28 00 be b5 	stq	s4,40(sp)
 d24:	0c 04 f2 47 	mov	a2,s3
 d28:	50 00 fe b7 	stq	zero,80(sp)
 d2c:	f2 ff 5f 21 	lda	s1,-14
 d30:	50 00 48 a4 	ldq	t1,80(t7)
 d34:	38 00 fe b7 	stq	zero,56(sp)
 d38:	48 00 fe b7 	stq	zero,72(sp)
 d3c:	09 00 22 45 	and	s0,t1,s0
 d40:	30 00 3e b4 	stq	t0,48(sp)
 d44:	40 00 3e b6 	stq	a1,64(sp)
 d48:	50 00 5e b2 	stl	a2,80(sp)
 d4c:	1a 00 20 f5 	bne	s0,db8 <ksys_getdents64+0xd8>
 d50:	00 00 7d a7 	ldq	t12,0(gp)
 d54:	f7 ff 5f 21 	lda	s1,-9
 d58:	00 40 5b 6b 	jsr	ra,(t12),d5c <ksys_getdents64+0x7c>
 d5c:	00 00 ba 27 	ldah	gp,0(ra)
 d60:	00 00 bd 23 	lda	gp,0(gp)
 d64:	0d 71 00 44 	andnot	v0,0x3,s4
 d68:	0b 00 e0 43 	sextl	v0,s2
 d6c:	12 00 a0 e5 	beq	s4,db8 <ksys_getdents64+0xd8>
 d70:	30 00 3e 22 	lda	a1,48(sp)
 d74:	10 04 ed 47 	mov	s4,a0
 d78:	00 00 7d a7 	ldq	t12,0(gp)
 d7c:	00 40 5b 6b 	jsr	ra,(t12),d80 <ksys_getdents64+0xa0>
 d80:	00 00 ba 27 	ldah	gp,0(ra)
 d84:	00 00 bd 23 	lda	gp,0(gp)
 d88:	54 00 5e a1 	ldl	s1,84(sp)
 d8c:	48 00 3e a4 	ldq	t0,72(sp)
 d90:	8a 08 00 44 	cmovlt	v0,v0,s1
 d94:	04 00 20 e4 	beq	t0,da8 <ksys_getdents64+0xc8>
 d98:	38 00 5e a4 	ldq	t1,56(sp)
 d9c:	08 00 41 b4 	stq	t1,8(t0)
 da0:	f2 ff 5f 21 	lda	s1,-14
 da4:	0e 00 20 e5 	beq	s0,de0 <ksys_getdents64+0x100>
 da8:	01 50 60 45 	and	s2,0x2,t0
 dac:	10 00 20 f4 	bne	t0,df0 <ksys_getdents64+0x110>
 db0:	1f 04 ff 47 	nop	
 db4:	14 00 60 f1 	blbs	s2,e08 <ksys_getdents64+0x128>
 db8:	00 04 ea 47 	mov	s1,v0
 dbc:	00 00 5e a7 	ldq	ra,0(sp)
 dc0:	08 00 3e a5 	ldq	s0,8(sp)
 dc4:	10 00 5e a5 	ldq	s1,16(sp)
 dc8:	18 00 7e a5 	ldq	s2,24(sp)
 dcc:	20 00 9e a5 	ldq	s3,32(sp)
 dd0:	28 00 be a5 	ldq	s4,40(sp)
 dd4:	1f 04 ff 47 	nop	
 dd8:	60 00 de 23 	lda	sp,96(sp)
 ddc:	01 80 fa 6b 	ret
 de0:	50 00 5e a1 	ldl	s1,80(sp)
 de4:	01 50 60 45 	and	s2,0x2,t0
 de8:	2a 01 8a 41 	subl	s3,s1,s1
 dec:	f0 ff 3f e4 	beq	t0,db0 <ksys_getdents64+0xd0>
 df0:	00 00 7d a7 	ldq	t12,0(gp)
 df4:	10 04 ed 47 	mov	s4,a0
 df8:	00 40 5b 6b 	jsr	ra,(t12),dfc <ksys_getdents64+0x11c>
 dfc:	00 00 ba 27 	ldah	gp,0(ra)
 e00:	00 00 bd 23 	lda	gp,0(gp)
 e04:	ec ff 7f e1 	blbc	s2,db8 <ksys_getdents64+0xd8>
 e08:	00 00 7d a7 	ldq	t12,0(gp)
 e0c:	10 04 ed 47 	mov	s4,a0
 e10:	00 40 5b 6b 	jsr	ra,(t12),e14 <ksys_getdents64+0x134>
 e14:	00 00 ba 27 	ldah	gp,0(ra)
 e18:	00 00 bd 23 	lda	gp,0(gp)
 e1c:	e6 ff ff c3 	br	db8 <ksys_getdents64+0xd8>

0000000000000e20 <__se_sys_getdents64>:
 e20:	00 00 bb 27 	ldah	gp,0(t12)
 e24:	00 00 bd 23 	lda	gp,0(gp)
 e28:	f0 ff de 23 	lda	sp,-16(sp)
 e2c:	12 00 f2 43 	sextl	a2,a2
 e30:	00 00 5e b7 	stq	ra,0(sp)
 e34:	10 00 f0 43 	sextl	a0,a0
 e38:	00 00 7d a7 	ldq	t12,0(gp)
 e3c:	00 40 5b 6b 	jsr	ra,(t12),e40 <__se_sys_getdents64+0x20>
 e40:	00 00 ba 27 	ldah	gp,0(ra)
 e44:	00 00 bd 23 	lda	gp,0(gp)
 e48:	00 00 5e a7 	ldq	ra,0(sp)
 e4c:	1f 04 ff 47 	nop	
 e50:	10 00 de 23 	lda	sp,16(sp)
 e54:	01 80 fa 6b 	ret
 e58:	1f 04 ff 47 	nop	
 e5c:	00 00 fe 2f 	unop	

--zhXaljGHf11kAtnf--
