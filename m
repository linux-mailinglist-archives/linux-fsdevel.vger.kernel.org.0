Return-Path: <linux-fsdevel+bounces-58787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283BB3174B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A3CAE35F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4092FAC1C;
	Fri, 22 Aug 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDL34KSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172962FA0E8;
	Fri, 22 Aug 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864728; cv=none; b=cO0y2OZi87Hmj/oM4oXWByT566A/SHPwF5XItektoMkytK4sRi9URTsq/n6WiPztZkKLLtYb5XBcTqs9s7OwkbqAPofQNtZnSL8Saf1JWdcJjz5evjJS2aZc4tARRVU9Wd0r4NLeeKhi/n2LqtX1EAXMm+GQATW7ydMcnbDqomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864728; c=relaxed/simple;
	bh=JixJZBViEsm9YIRDDbQPDdtmeElUGkQ6fDVS/5WM/AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=h5MkoBT/3+bqpuHFAT6A8V0pEPbGiQ9deeOZYhphLxUZMauMklrcRmTjK3bllJBdU2vk/0Dv53HAv/sfyG6+HnaSnSG6hg60cFZWuOQlFVThyj641zJmE2Z0/BJSu59LIxjeKgi9NT6WA9aI38AXtSCJdwRpG2T3rtptR1HAMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDL34KSv; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-323266d0535so183831a91.0;
        Fri, 22 Aug 2025 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755864726; x=1756469526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVbVGGKurfMZUPpXE56/zmXSSbdaJlQmE7CWoa6w9rI=;
        b=lDL34KSvhv3N7ZqTmnEaXy4PHeOvdzuwyCe6k9kNDxS5zgnC1XcD+vNbDbzJscKetk
         EfHLqrNkx3ORfQsEg10qej7dbbPUG8uYjpxBTbLlVi0HnkzhyVHSy1T9uCrRpK03tcp9
         rPRD0VF+7gSq63LmHvzBlMuK9U5TmN7TX4O4qSCe9BY0Sjg//6yJgnV8gGuSapDTpj2O
         PXtW+ye+JIqUPs6cgpaxzCS0F3gz9eQRtpzjeCL8IPA3zNtT+/TNRXs5cV3yk64z43To
         kqcjmZdnpHZjpYNqpagTexIYNJ9p6LCZ0k/2+L46Vt1Pg+4RWIS70RL027RPII8UIeX1
         2h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864726; x=1756469526;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVbVGGKurfMZUPpXE56/zmXSSbdaJlQmE7CWoa6w9rI=;
        b=u8bmxjth8InymzV1LYALTDk5950EHHW7aG5Q23QmnkLnJ3SNjYYZ8OfFg4I0qhOHFO
         OVNbjk/FgsbdmXusnWiwvwLvmQ+Ob0LoLWiqbwSfJ7UZkEaFgapa60dyVd/CmRAbriTl
         B9HGNvbqUSX/qMR/USVpfo62DISSnBXlXn3ygt2yb/6o8j1fZe7tj9t5m49vuELDMupB
         WqGFuqaLQTVUF3v7fK4UlV83SVA0MOJAl3E2+rzIvblN8sHEw4k5K9v3ivWX118LQrvL
         NrHSn1EI+e8i4uS7QIP7vNc9rLWevimvkyYTJ/cgfxt1c612mhEmhRvbq5huIGtHN3oS
         wmKA==
X-Forwarded-Encrypted: i=1; AJvYcCUf32WA5NSCviO73sPh0cx0xMiH+ab+DFe22pAGtwcDBticjWR0KjUsuIT6vh6IB7lvgqdNKFqlz8qeyg==@vger.kernel.org, AJvYcCUgRgSYiZnTQqfKOEQdwo9R3AmlyjekJleJfxoH1R2VAB/+b+zBDB3eAELXhxpyPynnkJjbxztLGU7t@vger.kernel.org, AJvYcCWVadUtSbK+u1XEgf04Nn8yzI9btKVAUIRAHfR7V+3pHVnNc18vT2A832AKwdHtP0jXEY+GtFkowc/Kog==@vger.kernel.org, AJvYcCXbMOi2K7be5zVQUDBjg155mFZBV/pVKxQw7bmPScsjgkAlvybFF6/dU2QsBr8k+fjwMrn0F33RlaiabqkG9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpw6sxqYsgZgpq2GW5C9uxU8+l1GeKx0TN65C+H8RzjrSD4fk
	gT4tJORYePV9EaTbc4WbAzvUq+0mNKGnN8DU7bS7csNkVJIWoUCbHQLm
X-Gm-Gg: ASbGncsqiMKtAQ+M//7kNdYo1zkJOH67mUuPkOJLTW1YCINYmTc8ascf3QboomF2MA8
	KpU62Gc4eUYD1CYW8NRxr9RVEuyRjLUU+6Fha1iWakoVVDF1tL8dQYapeUYR/Xtj8cTkKqZzW3G
	Vxtg+YAiG6/NCZT9FzRtRm1WMIDHszcQ/mXiYeKfKdDEaV7Z4ZKD/MSBV/J8z0xkBndqrcuXN/s
	zBMCEe0pkJXA1B/lPqbXdWa2TvH6uz1SedysAYn66gjTKryucfB8ye4veF+9BJsYwEnGXIPM7pO
	6/GCetPkx2T3Hp4Gzstgf5l7zRer00dKcKk5EeKVE/Mx8/XGy+adw7B7wEXE4etLwqyFDo2KaMn
	PELASYLq94Umo0DE/G+KUzoAF1I51t9KLY8Hp0ndzMcSh8qUtGJMPQuE=
X-Google-Smtp-Source: AGHT+IGVia1DXp14xUeh7rLANNIRhnIIgtJmqrkXoVQ1Qc7QbArXLBGWo4LWRWcL9JY0x+d5yXeGkA==
X-Received: by 2002:a17:903:1d2:b0:240:3e41:57a3 with SMTP id d9443c01a7336-2462eb662c2mr22147575ad.0.1755864726171;
        Fri, 22 Aug 2025 05:12:06 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73b6sm82062085ad.76.2025.08.22.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:12:05 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: mmpgouride@gmail.com
Cc: brauner@kernel.org, josef@toxicpanda.com, kernel-team@fb.com,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 sunk67188@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] make the i_state flags an enum
Date: Fri, 22 Aug 2025 20:11:59 +0800
Message-ID: <3846996.MHq7AAxBmi@saltykitkat>
In-Reply-To: <ED0538C1-E4C4-423F-9251-9C75F8ABE691@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> On Aug 22, 2025, at 19:18, Sun YangKai <sunk67188@gmail.com> wrote:
> > Hi Josef,
> >=20
> > Sorry for the bothering, and I hope this isn't too far off-topic for the
> > current patch series discussion.
> >=20
> > I recently learned about the x-macro trick and was wondering if it might
> > be
> > suitable for use in this context since we are rewriting this. I'd
> > appreciate any thoughts or feedback on whether this approach could be
> > applied here.
> I think x-macro is easy to write, but hard to read or grep.

I agree.
However, in this particular case, it's not very difficult to read and it do=
es=20
help reduce some copy-pasting. So it really comes down to what we value mor=
e=20
in our codebase: straightforward implementation, or adhering to DRY=20
principles.

>=20
> > Thanks in advance for your insights!
> >=20
> > Below is the patch for reference:
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index d7ab4f96d705..6a766aaa457e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2576,28 +2576,36 @@ static inline void kiocb_clone(struct kiocb
> > *kiocb,
> > struct kiocb *kiocb_src,
> >=20
> >  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to
> >  wait
> >  * upon. There's one free address left.
> >  */
> >=20
> > -#define __I_NEW 0
> > -#define I_NEW (1 << __I_NEW)
> > -#define __I_SYNC 1
> > -#define I_SYNC (1 << __I_SYNC)
> > -#define __I_LRU_ISOLATING 2
> > -#define I_LRU_ISOLATING (1 << __I_LRU_ISOLATING)
> > -
> > -#define I_DIRTY_SYNC (1 << 3)
> > -#define I_DIRTY_DATASYNC (1 << 4)
> > -#define I_DIRTY_PAGES (1 << 5)
> > -#define I_WILL_FREE (1 << 6)
> > -#define I_FREEING (1 << 7)
> > -#define I_CLEAR (1 << 8)
> > -#define I_REFERENCED (1 << 9)
> > -#define I_LINKABLE (1 << 10)
> > -#define I_DIRTY_TIME (1 << 11)
> > -#define I_WB_SWITCH (1 << 12)
> > -#define I_OVL_INUSE (1 << 13)
> > -#define I_CREATING (1 << 14)
> > -#define I_DONTCACHE (1 << 15)
> > -#define I_SYNC_QUEUED (1 << 16)
> > -#define I_PINNING_NETFS_WB (1 << 17)
> > +#define INODE_STATE(X) \
>=20
> And it should be INODE_STATE().

Yes, but I defined X as a parameter so that other names can be used as well=
=2E=20
This is particularly important in the file /include/trace/events/writeback.=
h,=20
where the macro X must be consistently defined wherever show_inode_state is=
=20
used. Therefore, it=E2=80=99s better to use a more meaningful name=E2=80=94=
such as=20
inode_state_name=E2=80=94instead of X. The situation is slightly more compl=
ex than a=20
typical x-macro, since we cannot undefine the helper macro (whether it's ca=
lled=20
X or, in this case, inode_state_name).
>=20
> > + X(I_NEW), \
> > + X(I_SYNC), \
> > + X(I_LRU_ISOLATING), \
> > + X(I_DIRTY_SYNC), \
> > + X(I_DIRTY_DATASYNC), \
> > + X(I_DIRTY_PAGES), \
> > + X(I_WILL_FREE), \
> > + X(I_FREEING), \
> > + X(I_CLEAR), \
> > + X(I_REFERENCED), \
> > + X(I_LINKABLE), \
> > + X(I_DIRTY_TIME), \
> > + X(I_WB_SWITCH), \
> > + X(I_OVL_INUSE), \
> > + X(I_CREATING), \
> > + X(I_DONTCACHE), \
> > + X(I_SYNC_QUEUED), \
> > + X(I_PINNING_NETFS_WB)
> > +
> > +enum __inode_state_bits {
> > + #define X(state) __##state
> > + INODE_STATE(X)
> > + #undef X
> > +};
> > +enum inode_state_bits {
> > + #define X(state) state =3D (1 << __##state)
> > + INODE_STATE(X)
> > + #undef X
> > +};
> >=20
> > #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> > #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > diff --git a/include/trace/events/writeback.h b/include/trace/events/
> > writeback.h
> > index 1e23919c0da9..4c545c72c40a 100644
> > --- a/include/trace/events/writeback.h
> > +++ b/include/trace/events/writeback.h
> > @@ -9,26 +9,10 @@
> > #include <linux/backing-dev.h>
> > #include <linux/writeback.h>
> >=20
> > -#define show_inode_state(state) \
> > - __print_flags(state, "|", \
> > - {I_DIRTY_SYNC, "I_DIRTY_SYNC"}, \
> > - {I_DIRTY_DATASYNC, "I_DIRTY_DATASYNC"}, \
> > - {I_DIRTY_PAGES, "I_DIRTY_PAGES"}, \
> > - {I_NEW, "I_NEW"}, \
> > - {I_WILL_FREE, "I_WILL_FREE"}, \
> > - {I_FREEING, "I_FREEING"}, \
> > - {I_CLEAR, "I_CLEAR"}, \
> > - {I_SYNC, "I_SYNC"}, \
> > - {I_DIRTY_TIME, "I_DIRTY_TIME"}, \
> > - {I_REFERENCED, "I_REFERENCED"}, \
> > - {I_LINKABLE, "I_LINKABLE"}, \
> > - {I_WB_SWITCH, "I_WB_SWITCH"}, \
> > - {I_OVL_INUSE, "I_OVL_INUSE"}, \
> > - {I_CREATING, "I_CREATING"}, \
> > - {I_DONTCACHE, "I_DONTCACHE"}, \
> > - {I_SYNC_QUEUED, "I_SYNC_QUEUED"}, \
> > - {I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"}, \
> > - {I_LRU_ISOLATING, "I_LRU_ISOLATING"} \
> > +#define inode_state_name(s) { s, #s }
> > +#define show_inode_state(state) \
> > + __print_flags(state, "|", \
> > + INODE_STATE(inode_state_name) \
> > )
> >=20
> > /* enums need to be exported to user space */
> >=20
> > Best regards,
> > Sun YangKai
> > <x-macro.patch>

Thanks,
Sun YangKai





