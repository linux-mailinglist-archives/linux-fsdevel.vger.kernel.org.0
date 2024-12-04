Return-Path: <linux-fsdevel+bounces-36409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E39E383C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA791615AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39641B21B3;
	Wed,  4 Dec 2024 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNFra3BR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC121B0F2E;
	Wed,  4 Dec 2024 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310308; cv=none; b=Cg4oPqiNOp1Re6WSAZn/K7wfICwDeM9RgasVLrZk6lc7U95ANBVHUtV8+5Kjatafy5+pwQbV+0SrbWHecwWGtQRypXHNnVJXAgZuB+cWJjSFpY2pEbMdO9r6uFFyFkyIj2coTjo8skiPrV3/7iccfZwXOg3av/Jo9Ty+BTDQG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310308; c=relaxed/simple;
	bh=51TdTifeSvLvI83JsA7+gyBk7k4Ry9GmmMnPVzQefmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyruJTIhQCB3ZmuY55GcfFffu8Y74ClKNz3s4L44IJaFkg17zDU0b0rafcBjAZcKipoXnEL1rRIc+JIdkpTKroi/Xu/wr8QiMmEtU6rhfHLRXfSr93274O5c/Y10KOghKO3OvXO0M3euTukdZWCwJ4ofD+mRL+P37Iz0Qt0IqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNFra3BR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0bde80b4bso6875169a12.2;
        Wed, 04 Dec 2024 03:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733310305; x=1733915105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8iOMTKaSNU+mizzDkRbhYPc/Yr2+80O2QZAV03wO8Y=;
        b=XNFra3BRSNxQ0JGfFwZsixN3qxkLWucpgaNH+qivsFlbxmRR4Rk9HdP1AGnlQ38mlR
         2ahxxAaLueqEYEOLAxJzbUA/mfRTrSG3SVFyouD13dLw0xQ1QughsVibNT9LufrZOBsa
         d6YU56j3VN2t9nrUy382UXdwxAbKlqi5frZ1b8s9+8sGlBb6it7k9yNqe0vGlvkh3Igo
         QEZ1bVotSOiPdCd9f3OzJ4b9hXj1j8RNd5fzBtb7LlHLnRY+SkENuRC+pegBqrl1elwm
         mWBtuWf/62uPXu7JOdsU3MBreZVsY3a2Smwy8p0+79FcUutL1eFXTkqmWxy0dpfbn06M
         cPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310305; x=1733915105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8iOMTKaSNU+mizzDkRbhYPc/Yr2+80O2QZAV03wO8Y=;
        b=T1rz+gZCFY8xfOVtSbzG3/Lcy/pwV48RczFt/ffhJlHpGi/FfXzz4i+cY/DZ/cML8a
         dC+M9S9OOkIK0knfG5w2BcG4MvezRoQExIWr2vnrIKg5zxN4eQhSZX76hxqyx7XRlt8I
         LxW4JDXQuIqN0vVw8fsZxi0uKo5VwSE2hVe5z4fJ8siB23VtOR24GYWyHymjte/HAz12
         5yS7qU+WGgyiYU29upuaYzUj7NpVMHMTt9gGRLli7Kzc74TwfESMLjuKVN0XHdynrQK0
         7BuJehraJaf80dSUf1i+TnHP4ZWAyvUMxsm2vcsy6SvaBYg8Nbi+1NMIKVp+XOzJK8AX
         oQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUDqGD++2vLMK3FW6oW0eiW/3WcbrbtnS/LM4b3G90INOFqruOYQzUysCrZni3diCRxJzBDMp4xC3yXJqJ81A==@vger.kernel.org, AJvYcCUu3/mqwN93U8/4W4GHgMAmsm+exTQUjFbXDqg/USVYlG94kloidJfgm8s1CiRww3wVbiFXTok4jFuPqNmQD+YSU3lGKYoH@vger.kernel.org, AJvYcCXDPeCroWPyKDNYW/TgBDtn3gG6RYwYGm2rFsNVO4NFVz6YcZP6zvr97Fr5+/VTNMY1Lta1MGOiHwIMcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44lp4b+7clVojpXg+akI/+Hm4KrpQ4rNl4EDvrFwJM6H5jxXg
	3RNKpn0zY84jXMy3Sz+v/sWU6g/IZOeNsUW2CpenKnwMlBFp0hZq
X-Gm-Gg: ASbGnctLGF1TFdtc1QS7pEicRVOwcoMEMeV7nUKe/N4g2Ukj2fALGOiWlkYBt6OsAlo
	JTBoUjLfMWs3J/sVYw5E1LgGs1ko4Nk/0vjwDmERea3saHGa3nYomO60cyNS8aIInTIK4Xu9u9s
	sR05DG2yYAVxmYNepM6vsxPVsLchPV8enfefmaOAM+whATYFyjmHciNNuqdaNYewyQGj7N4LsmW
	gslXaQejQf94Ix2p7u6uLs6KoE29qeBT6PYaPxytjeIx1ADaxAuZGuItpN5fqI=
X-Google-Smtp-Source: AGHT+IHKPs8LBcfpZx6PibQeJxtDt6cqZyCFXJ3okqVzv0rezJbiLU2OBMvmFMVtFGSmEBG7F0FqMQ==
X-Received: by 2002:a05:6402:2113:b0:5d0:d610:caa2 with SMTP id 4fb4d7f45d1cf-5d10cb81015mr6132139a12.26.1733310304739;
        Wed, 04 Dec 2024 03:05:04 -0800 (PST)
Received: from f (cst-prg-17-59.cust.vodafone.cz. [46.135.17.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0cfcfe774sm4701654a12.88.2024.12.04.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:05:03 -0800 (PST)
Date: Wed, 4 Dec 2024 12:04:55 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	agruenba@redhat.com, gfs2@lists.linux.dev, amir73il@gmail.com, mic@digikod.net, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/11] fix hungtask due to repeated traversal of inodes
 list
Message-ID: <7t3guwcsncthkznwxxhtfd73ihho55qwqcaw6pr7h5sqriylxc@vkf7fkbgk2cd>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>

On Mon, Nov 18, 2024 at 07:44:57PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> introduces the retry logic. In the problem environment, the 'i_count'
> of millions of files is not zero. As a result, the time slice for each
> traversal to the matching inode process is almost used up, and then the
> traversal is started from scratch. The worst-case scenario is that only
> one inode can be processed after each wakeup. Because this process holds
> a lock, other processes will be stuck for a long time, causing a series
> of problems.
> To solve the problem of repeated traversal from the beginning, each time
> the CPU needs to be freed, a cursor is inserted into the linked list, and
> the traversal continues from the cursor next time.
> 

I'm surprised this was not sorted out eons ago.

My non-maintainer $0,03 is as follows:

Insertion of a marker is indeed the idiomatic way to fix this, but I
disagree with the specific implementation.

All cond_resched() handling should be moved into the magic iteration
machinery, instead of random consumers open-coding it.

