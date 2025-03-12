Return-Path: <linux-fsdevel+bounces-43769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEA8A5D769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B4176065
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E61F460E;
	Wed, 12 Mar 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8ziwqpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A41F4189
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765144; cv=none; b=aYsdzd/IHzqUqXu8lVCaaN7macXew30HDbRnASUOhlITkT4APsR8nWmwwHxpEgeHbUaJwvFq9tefUeN24+xD6C7NIFVV6lEcVgg81tC5/fEp0hdVNjO7JMNA5oO72A7FtuOup3I56dvw+hjZxJKklcmkkP1jtN/XN1nLYQGWyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765144; c=relaxed/simple;
	bh=rIdZaMOG1OllLvgGZYBp7irCaTgsJWQCKL42wdvbus4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHgLjc9sSL2AnQTPIfQI/UvmsVguCYQIrMzp6JLPXA+HADRXoMyUq7Gtf2TCCOmgCNNC3A9zWNA27AYPh9+xGlu7qZYFrc+WE7qwbQs+HJlIBmBGiMZX/YWbSAad3bRUANNkTHsuqYAFAdPAbof8VhjrVxHt0GQJ0UWUEwgcjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8ziwqpB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so1104071a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765141; x=1742369941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65GvubruvAwnXn23fDL08iWQ2RuiFUdJoZxy85RDjnI=;
        b=m8ziwqpBg/UQ9ZnpyIDYyAE1Ge23UYwbtnBQFznd34uxF6r7KRSh2h4qGC9+l21EKI
         vsUEuHFKlzxYwXNMhupy8FHpCzsUDt2QN4ncdfEnZD/iYOYuhO29/GciMeHBNjHLHYgl
         FQnrXzlO+swJsfFM4e3X9hGWBsTyn5ywJUmLPmhP60rwZA5IL/zWqEiOOce4sPUbJiRo
         J+j0v5fMonug/gkPhNQ3cXaOVLPH6tLo/Ad8ztNX/A26uChNLkco1dZnV2PAl0zvkaSW
         pZlwaOX2LfTO5gtvtOTdK2qzqkIO6kusqvIUwUAaOMYWaABbK4YrYRlxIFYDRSn1cwQg
         pPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765141; x=1742369941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65GvubruvAwnXn23fDL08iWQ2RuiFUdJoZxy85RDjnI=;
        b=vg9mam/MOmWGZKG4G9XSTT4HmrmJzQdfZe1JPgONE70E4Pfud0Q6HXds22TRg7CJjA
         Z7QwLOOKQpTySYyokuJnEaPj7gRDpHAwknJJaD4eoGAETJ3v3s6g+uUqIJKXBG1DWBds
         cBtjHj5W+lJrCBHJvdliNOHIjF8HwZxgw3jjsUMWIGNmO3WiG9zSY4la78+bL+2Ry0/a
         pa6AHXgLfTRMOV48n6wP58fMzgNlexNDpxOm02RkyV/wzjkTjqxzjZhgOAplpAEUM43e
         oGAmE0yM0RRF880AXlSdjIefTXhdTaE+M4QnaEv38uOucJs/XcntFuI0f3Ern3LkNYFi
         hHhg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGmpfWZWkXDPXWNXGm2vIFnu92Co/O/4L2fkuH51oPHSF39rNX4d9LMfosBEToQCJrwgAslp3FEzfxPBm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WuABZTUPu/oOrAo/tFOFFjhifWrBEfmNoFvHyhjmwsyy5mUx
	ZXI9BzD7YKK9xnhAP9gKqlZF7qP3jWpKYV7e4RCHidoR6qAgW8N7
X-Gm-Gg: ASbGncvQgkv18iABuDv+cOYOiSao8kMMrgwPpl8ChWqFcLiQQEswQHgscQczZhcfAcY
	0Kz8nC472ZEKvllOUrFLeEjHbiNu2B+dpW0RIFNYLm1JKV8q7V6/11lTHObABzYzLASLg/fFNFA
	ArGLR8ZC25Ka2YLM1L8ag511i3tnO4vdqt6ODwFc4X9wl4ANtX3ZzvoLO3lpfNNu1tbaeggg5I0
	zPpIx7dHN70TRO2aLeBjbX00bNAcIZmT4YFV7TmS0EQH1nMkX2CWx1UrM0hDhlYZaHRVLwbBZ6g
	ldZYTeeWboVYNC01hPlA+V05yGIK19YCJvcnTw22i1kcL4l5AJi4g31yA0GPJA2T6HhChZXz+iO
	g0cqA/HpHODZLxmFPfakAy+U+35NLDC8KV3rG+ofP0Q==
X-Google-Smtp-Source: AGHT+IFzqgzDh5BfHoGID/hLVETbYPMEi9MUrXjEiVyz3eP90S6PN9ly2p0EfuRPl3W1AHc8uRoshw==
X-Received: by 2002:a17:907:9d17:b0:abf:24f8:cc1e with SMTP id a640c23a62f3a-ac2ba47350fmr794768266b.2.1741765140791;
        Wed, 12 Mar 2025 00:39:00 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:00 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/6] Fix for potential deadlock in pre-content event
Date: Wed, 12 Mar 2025 08:38:46 +0100
Message-Id: <20250312073852.2123409-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

This is the mmap solution proposed by Josef to solve the potential
deadlock with faulting in user pages [1].

I've added test coverage to mmap() pre-content events and verified
no pre-content events on page fault [2].

After some push back on [v2] for disabling page fault pre-content hooks
while leaving their code in the kernel, this series revert the page
fault pre-content hooks.

This leaves DAX files access without pre-content hooks, but that was
never a goal for this feature, so I think that is fine.

Thanks,
Amir.

Changes since v2:
- Revert page fault pre-content hooks
- Remove mmap hook from remap_file_pages() (Lorenzo)
- Create fsnotify_mmap_perm() wrapper (Lorenzo)

[1] https://lore.kernel.org/linux-fsdevel/20250307154614.GA59451@perftesting/
[2] https://github.com/amir73il/ltp/commits/fan_hsm/
[v2] https://lore.kernel.org/linux-fsdevel/20250311114153.1763176-1-amir73il@gmail.com/
[v1] https://lore.kernel.org/linux-fsdevel/20250309115207.908112-1-amir73il@gmail.com/

Amir Goldstein (6):
  fsnotify: add pre-content hooks on mmap()
  Revert "ext4: add pre-content fsnotify hook for DAX faults"
  Revert "xfs: add pre-content fsnotify hook for DAX faults"
  Revert "fsnotify: generate pre-content permission event on page fault"
  Revert "mm: don't allow huge faults for files with pre content
    watches"
  Revert "fanotify: disable readahead if we have pre-content watches"

 fs/ext4/file.c           |  3 --
 fs/xfs/xfs_file.c        | 13 ------
 include/linux/fsnotify.h | 21 ++++++++++
 include/linux/mm.h       |  1 -
 mm/filemap.c             | 86 ----------------------------------------
 mm/memory.c              | 19 ---------
 mm/nommu.c               |  7 ----
 mm/readahead.c           | 14 -------
 mm/util.c                |  3 ++
 9 files changed, 24 insertions(+), 143 deletions(-)

-- 
2.34.1


