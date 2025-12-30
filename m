Return-Path: <linux-fsdevel+bounces-72245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D1CE9D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF681301BEB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AE228CB8;
	Tue, 30 Dec 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKdjwZH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37174594A
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102647; cv=none; b=UC9ObBowi34gn8LySyrjknYzufd6S3ksCVLD2p0ZmPOskimkMeyH/aX9iCs2uX5mOqRwNh+q/ll+3wRtJVXnTSMaVg6wY154NvowzGV62YINC/pd2JoWfX3BYQBytJLX+j+Adq/++2UjJXzOP17IMlxycYHiXuCfsISDt5VlR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102647; c=relaxed/simple;
	bh=T5wvdjCPg8PuhFR1pXN1iGJFo3d8MM/pdznXbVxjkqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0Xvmpc4RoPY0sX6GtvMej+72/VIQH4Xi90aUguPd27BRw63TS32eiaU5z2+VTegi5vSKFROMhQa3b+EXGe43C3TQj8G7EKheOVb9LXb8IDne/c4qkPMwgl2rlzy9JI+38BPj/mHpnK6VA5eX9nCttbwTNaOv5iOR3u3cRdkCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKdjwZH7; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65d0441b6feso5462812eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767102645; x=1767707445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46uAt53bXrO63AYOm/n+OwROEOKy1TWgUO7XKdbAN1E=;
        b=mKdjwZH7F5OvPjLgLIcpTjUe0lrlHfUq6NAkoEwss/z6CyiTn+6EdwPEGXgn3GgGVs
         fKIQOB9wGAg8LLipy+WUJZLj2SPajLgOIaOkxubXZjU641nUmTumsslTR9MXT5pnPnIW
         7Pycw84WHrQjOfrstoZhbjzLjiOFlnLq0epXyyzY0VfyBrbqt+bWsujkWAuOhhZpX6F8
         36Z9tZGP2PXelW8xCIPR9jCR7RHhi7l61LZp/IVQdB3zTp+YQCH0nSJhewoWYPbrqRlW
         WTO5DVv6TtWM4c7hEz3ZCuTGy160QMECFqA++k4zDK6R+lYOwK2xYcSEc8mWOBTod2+s
         YcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767102645; x=1767707445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46uAt53bXrO63AYOm/n+OwROEOKy1TWgUO7XKdbAN1E=;
        b=ikVwbuOfqtj9aLa/XoSXCWBRDidNY0R5Emj+6itggUJHabY5Z6EmRxkUBMT2vPdn5a
         gN5zqq+jCCc6gvwzdZSgn8M+0nkjR4lNMfx1Gy6z9cxXwAvvF1X+LbTRS74BbuG3K5ji
         4vo0JC9fP+qD7s0ZIX5m0PrI7KUuu8DNeLrwKIjdTL/EjvYOKWrTs6hRYHTtgIaRgxsw
         2P61+anrbDYeVXncFqWXmS/ULLchs8Q4DuN+LV4OLWgmcMd3JorMhb6byMNg1i2Cs2ha
         rrRGV3ernljqVqqdLzMZundp1GpNitiga/kUhbDbQ3z87NYi3a65QngA3vHsOK02glG4
         LnkQ==
X-Gm-Message-State: AOJu0Yy52QZaUKHh2s5O4pqHrr0+kDYRwUlCMNHWgftAjmXhFi+lPDUH
	LhmFHGkpW8APd2TyUmZRzirXETy1soZ69IEEuwnkzg/Hvu3gTSy62cCTemcl+d/NzONt071qcKH
	BkXrCW9tXtobdZLtLuih3OB2XOheCunLGq6x+TtI=
X-Gm-Gg: AY/fxX5xlHX6g/Azsm7STGWV2DNUV4kxjN79k7t4UMJqaA9+3UPhmJiF76AXPqb37qt
	XBTEemWz/0aQTzucieY4mVfYoIBtUWHfCgCOVLV85s+QxZfIYpys9AO7PQYnoC9yICNVfo3TOyO
	imrge8GLfQOaTc1AOAQwBsK1MMHOWho0tJMb++NXfkI1XHZ421nv2RySkcE8HpOzxc/9xlajYuJ
	PDdCRVyAmDhTZvk9x42rHvo6+FlO+jfrtKbwkjy45mE1crpgC4XKJjP6bCTkW6TOlpa
X-Google-Smtp-Source: AGHT+IG/nmT1xsHsMUgHyQNztRCwLj1gRq8tbTFDfJMqHg4mElvim04FJ9qP7JKJ+7xOJm3YSakxZqqRfQHCbRQBLiY=
X-Received: by 2002:a4a:ddc2:0:b0:65c:fe8b:53c7 with SMTP id
 006d021491bc7-65d0eab99b9mr12495773eaf.56.1767102644591; Tue, 30 Dec 2025
 05:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzV9_0qDaRJeaLLhs7DtVL8m8d5mUhrEAbe1GOy61dDKWj1fw@mail.gmail.com>
 <CAKYAXd_O93Wmbe=rYuv4fPcJJ-y98+vSJHcfu145kNiDNrzsXA@mail.gmail.com> <CAKYAXd8mAQw_LqS=1DRY32wje228CbVKVUq_eAsOBMYKhZKR=A@mail.gmail.com>
In-Reply-To: <CAKYAXd8mAQw_LqS=1DRY32wje228CbVKVUq_eAsOBMYKhZKR=A@mail.gmail.com>
From: Devourer <accelerator0099@gmail.com>
Date: Tue, 30 Dec 2025 21:47:46 +0800
X-Gm-Features: AQt7F2qKz762PX5WEb_X9BDasU7vUcRUGmsDeJGOp4bmgjfaMK7YJYUByo4xB94
Message-ID: <CACzV9_0y1V2Wd_+eUprrozhK_q0b5j_xARihq5q0uT-iuBu3nw@mail.gmail.com>
Subject: Re: [BUG] [exfat] Unable to mount exfat after commit 79c1587b
To: linux-fsdevel@vger.kernel.org
Cc: yuezhang.mo@sony.com, sj1557.seo@samsung.com, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

exfatprogs 1.3.1 fixed it! Thanks

On Tue, Dec 30, 2025 at 12:53=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
>
> > exfatprogs version : 1.3.0
> And please try to repair your exfat storage with exfatprogs 1.3.1
> version.(the latest version).
>
> Thanks.
>
> On Tue, Dec 30, 2025 at 9:15=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > Hi Devourer,
> >
> > Can you send me it after dump using the following command and compress
> > using gzip ?
> >
> > exfat2img -o sda1.dump /dev/sda1
> >
> > Thanks!
> >
> > On Tue, Dec 30, 2025 at 12:43=E2=80=AFAM Devourer <accelerator0099@gmai=
l.com> wrote:
> > >
> > > ## Mounting exfat produces:
> > >
> > > mount: /run/media/AWD1T: can't read superblock on /dev/sda1.
> > >        dmesg(1) may have more information after failed mount system c=
all.
> > >
> > > ## dmesg message:
> > >
> > > [  +3.177475] sd 6:0:0:0: [sda] 1953458176 512-byte logical blocks:
> > > (1.00 TB/931 GiB)
> > > [  +0.000560] sd 6:0:0:0: [sda] Write Protect is off
> > > [  +0.000004] sd 6:0:0:0: [sda] Mode Sense: 47 00 10 08
> > > [  +0.000547] sd 6:0:0:0: [sda] No Caching mode page found
> > > [  +0.000002] sd 6:0:0:0: [sda] Assuming drive cache: write through
> > > [  +0.041258]  sda: sda1 sda2
> > > [  +0.000094] sd 6:0:0:0: [sda] Attached SCSI disk
> > > [  +4.240762] exFAT-fs (sda1): failed to load alloc-bitmap
> > > [  +0.000006] exFAT-fs (sda1): failed to recognize exfat type
> > >
> > > ## However fsck says the fs is clean:
> > >
> > > exfatprogs version : 1.3.0
> > > /dev/disk/by-label/AWD1T: clean. directories 259, files 3744
> > >
> > > ## so does mocrosoft chkdsk
> > >
> > > ## The function exfat_test_bitmap_range() (at  fs/exfat/balloc.c)
> > > returns false at line 64
> > >
> > > ## If I insert some printk to show the details, it gives:
> > >
> > > i =3D 0, b =3D 96
> > > bit_offset =3D 32
> > > bits_to_check =3D 20
> > > word =3D ffc7ffffffffffff, mask =3D 000fffff00000000
> > >
> > > ## The modified code is:
> > >
> > > static bool exfat_test_bitmap_range(struct super_block *sb, unsigned =
int clu,
> > >         unsigned int count)
> > > {
> > >     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > >     unsigned int start =3D clu;
> > >     unsigned int end =3D clu + count;
> > >     unsigned int ent_idx, i, b;
> > >     unsigned int bit_offset, bits_to_check;
> > >     __le_long *bitmap_le;
> > >     unsigned long mask, word;
> > >
> > >     if (!is_valid_cluster(sbi, start) || !is_valid_cluster(sbi, end -=
 1))
> > >         return false;
> > >
> > >     while (start < end) {
> > >         ent_idx =3D CLUSTER_TO_BITMAP_ENT(start);
> > >         i =3D BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
> > >         b =3D BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
> > > printk("i =3D %u, b =3D %u\n", i, b);
> > >
> > >         bitmap_le =3D (__le_long *)sbi->vol_amap[i]->b_data;
> > >
> > >         /* Calculate how many bits we can check in the current word *=
/
> > >         bit_offset =3D b % BITS_PER_LONG;
> > > printk("bit_offset =3D %u\n", bit_offset);
> > >         bits_to_check =3D min(end - start,
> > >                     (unsigned int)(BITS_PER_LONG - bit_offset));
> > > printk("bits_to_check =3D %u\n", bits_to_check);
> > >
> > >         /* Create a bitmask for the range of bits to check */
> > >         if (bits_to_check >=3D BITS_PER_LONG)
> > >             mask =3D ~0UL;
> > >         else
> > >             mask =3D ((1UL << bits_to_check) - 1) << bit_offset;
> > >         word =3D lel_to_cpu(bitmap_le[b / BITS_PER_LONG]);
> > > printk("word =3D %016lx, mask =3D %016lx\n", word, mask);
> > >
> > >         /* Check if all bits in the mask are set */
> > >         if ((word & mask) !=3D mask)
> > >             return false;
> > >
> > >         start +=3D bits_to_check;
> > >     }
> > >
> > >     return true;
> > > }
> > >
> > > ## The disk is about 630GB so I can't upload it here. I can provide
> > > some blocks if required. Please tell me if I can do anything to give
> > > more information

