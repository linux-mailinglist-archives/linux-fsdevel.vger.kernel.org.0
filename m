Return-Path: <linux-fsdevel+bounces-72195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED0CE73CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7D93026B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DE32B98E;
	Mon, 29 Dec 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSUE6kGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314532B9A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022799; cv=none; b=VTUKiIyisJi26TaAEXyONHyT+9N+wIIzGFdUDhpnzL+a9syBVG8sbeRJrAYMpmh+hiGAqvkGF1V8qRA+MpNDKbSIsZkh2m/5yr3KMmpvkgtAi+jFyQ3pBzqzirUgIaIMV3xO+BPKlUy9CWzwdfNGWesL4OkmPGIQLYMTYgcNH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022799; c=relaxed/simple;
	bh=XwryuZi0uTU9EFaGThhkoOJ6M8f/+MIiOxtyENLQPIk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UMGPN+SMxwtEi9GBNdljOJhhcn/raU6SfMVXBGDezf6Fup9+mAe7ibwcEWlki1VvCYT5Md0kzlp4NqUep4ueW9/hqagb+YlaeLlmzMvb9XUqC10di+6FN1GSzq+/mxgFJVeWoyNrdTvRek1EZnu6NW1N/8JYTMISwuWTkl77Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSUE6kGm; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-659848c994bso4532532eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767022797; x=1767627597; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSdFJuT68YvIuaiA0MO2Fgksa1c4I3mBaRzX7eN+h8s=;
        b=gSUE6kGmXKTdrAC3t+dZU33dZchYUXyqlHWOmGZuw/9XJlq2junQCDMxxHDd3c82Ji
         4TUMxcC3u5vpI4Al+OI0zv/fEgD1n8vftsqgx5MOmRdDDzqqSS6y5wJWUfG7HPoSSR73
         EDWC8au1HalxaVDdQwUrIKhzDD0g81fSt6xYQagH7nlbeV01xiARzzNJL/49zbFXiXVc
         pIp3sTxOTwgKSQ5smFe+N/+9zKh+zTOClEuEe+NeK/1TpGG5x1BA1mX7aLD1gsEkaNXY
         aZccCYzRN37SBofkBj4S9IbovHJ/Rv0yMPXZ1+aylWQdeiNYJOBUE9r4bnMVCurdIRmt
         eC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767022797; x=1767627597;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSdFJuT68YvIuaiA0MO2Fgksa1c4I3mBaRzX7eN+h8s=;
        b=Shec862B5IhCIHrBeunE6xprrq9EYw/iuE1DRdCRRU3vyb+U4sICK8bEMT/m6DMtTa
         /0TaOEaXlF4PTWZK7XWXMYIhEhqHwU3Dm6OdGVamHBH/ICT17DJARqwWPQNB+myksPMU
         PuIRJPbXGDlTJi7wkNqgk/dNeGUW0xxsLt5TTWIT9yCrW2pADwgYKaOSi6EF/24GerA0
         ke/W0jOTlZnjU1C/H9gS/1E0z1ixI/YB0XPswpxORTtTStK4/WFmTM9Zh8viOWP7iYoB
         CmEn2xIbWCYfpNXA6juekBs3TET8/9c8W6t5WH4vwz3EQyYHlwjaJLOtSQuK3TDN6LAA
         mndA==
X-Gm-Message-State: AOJu0YwLbIuAGXu/BOcSCGnWy6Ni0YdVPKQSNctkSt8U/i7yFQjmHpJZ
	w6EUUBGckCgCtopWa08YNFvTOhLgR39Pl7asKXSzcMSt4b8FnZLHYPsmuSE3Z8DkDNO+d3GDjxH
	qh3FsIkUMGaJJOVHk+Oh4kXFznWpTAcJ/u/2qSDM=
X-Gm-Gg: AY/fxX53DpoaRJMEtZeE7LopZVmX5f39p+pqLvBTGdXVgfMKD+Mzm0yQc9cESCCar0o
	digUPZ5esKrxStnzFTbzCFhdfWmavXnZ50oeNoJn7yUmu7i0c/5oB2hZJNRBNJEnXdqeF2nPyg+
	6RfLy6/U46jq7RXRhZqbznTN05XmSciowSciUtM/C+MI6Jqg2M1vuAjViEKto8JdMsmis6BWCQC
	CbUoO5ViyJhR3pMFlP7U9M1RvmXrxOnVUPcPQ837fQ3szD+RjU2Nzbzlu6JBqHQzQX9
X-Google-Smtp-Source: AGHT+IHsICd7Z+EOAjyniy9oZ9YZDpHGbJ73bDv9JhE8YFI9UgqJl2DfCDBDkGPMhfTZCQ8ncHdYlKlpLzyJM/FO5aI=
X-Received: by 2002:a05:6820:1687:b0:659:9a49:8fde with SMTP id
 006d021491bc7-65d0e932cd7mr12635568eaf.11.1767022796723; Mon, 29 Dec 2025
 07:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devourer <accelerator0099@gmail.com>
Date: Mon, 29 Dec 2025 23:36:57 +0800
X-Gm-Features: AQt7F2qUponimgOZV-8XE1mZgTf6LKTYKVi3RcLaFH9k1LpdlvIXHGe51HayEOY
Message-ID: <CACzV9_3D7MRzK2CGNH1EX_V9xB+uaEAQR0snOU8nQ8u3Czw2ng@mail.gmail.com>
Subject: [BUG] [exfat] Unable to mount exfat after commit 79c1587b
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

## Mounting exfat produces:

mount: /run/media/AWD1T: can't read superblock on /dev/sda1.
       dmesg(1) may have more information after failed mount system call.

## dmesg message:

[  +3.177475] sd 6:0:0:0: [sda] 1953458176 512-byte logical blocks:
(1.00 TB/931 GiB)
[  +0.000560] sd 6:0:0:0: [sda] Write Protect is off
[  +0.000004] sd 6:0:0:0: [sda] Mode Sense: 47 00 10 08
[  +0.000547] sd 6:0:0:0: [sda] No Caching mode page found
[  +0.000002] sd 6:0:0:0: [sda] Assuming drive cache: write through
[  +0.041258]  sda: sda1 sda2
[  +0.000094] sd 6:0:0:0: [sda] Attached SCSI disk
[  +4.240762] exFAT-fs (sda1): failed to load alloc-bitmap
[  +0.000006] exFAT-fs (sda1): failed to recognize exfat type

## However fsck says the fs is clean:

exfatprogs version : 1.3.0
/dev/disk/by-label/AWD1T: clean. directories 259, files 3744

## so does mocrosoft chkdsk

## The function exfat_test_bitmap_range() (at  fs/exfat/balloc.c)
returns false at line 64

## If I insert some printk to show the details, it gives:

i = 0, b = 96
bit_offset = 32
bits_to_check = 20
word = ffc7ffffffffffff, mask = 000fffff00000000

## The modified code is:

static bool exfat_test_bitmap_range(struct super_block *sb, unsigned int clu,
        unsigned int count)
{
    struct exfat_sb_info *sbi = EXFAT_SB(sb);
    unsigned int start = clu;
    unsigned int end = clu + count;
    unsigned int ent_idx, i, b;
    unsigned int bit_offset, bits_to_check;
    __le_long *bitmap_le;
    unsigned long mask, word;

    if (!is_valid_cluster(sbi, start) || !is_valid_cluster(sbi, end - 1))
        return false;

    while (start < end) {
        ent_idx = CLUSTER_TO_BITMAP_ENT(start);
        i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
        b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
printk("i = %u, b = %u\n", i, b);

        bitmap_le = (__le_long *)sbi->vol_amap[i]->b_data;

        /* Calculate how many bits we can check in the current word */
        bit_offset = b % BITS_PER_LONG;
printk("bit_offset = %u\n", bit_offset);
        bits_to_check = min(end - start,
                    (unsigned int)(BITS_PER_LONG - bit_offset));
printk("bits_to_check = %u\n", bits_to_check);

        /* Create a bitmask for the range of bits to check */
        if (bits_to_check >= BITS_PER_LONG)
            mask = ~0UL;
        else
            mask = ((1UL << bits_to_check) - 1) << bit_offset;
        word = lel_to_cpu(bitmap_le[b / BITS_PER_LONG]);
printk("word = %016lx, mask = %016lx\n", word, mask);

        /* Check if all bits in the mask are set */
        if ((word & mask) != mask)
            return false;

        start += bits_to_check;
    }

    return true;
}

## The disk is about 630GB so I can't upload it here. I can provide
some blocks if required. Please tell me if I can do anything to give
more information

