Return-Path: <linux-fsdevel+bounces-12907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81795868567
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B257D1C223CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E44A28;
	Tue, 27 Feb 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVr8QJQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1384431;
	Tue, 27 Feb 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995701; cv=none; b=hWHunrvyf0KXnbhBdbqVW5LAmzX8fxjAmifmBE2TirHO/GGzeDBwO++ktcoU/LyTCe6R9c86nFpTyieIJuzYjIVdGRJJW5GYlMeTWL/Y46focaHhKAEPFArGcCVkHsBZ8ajB45dVEVL758hjO2cAjfkwWzfizEtaa6eMwbpP73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995701; c=relaxed/simple;
	bh=chz2G2oYg/GX+LoMzJsjN1GkgXA/I1MuwZnEeKWl34M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMB2akXdlOfIfbDAJtG0YpOsIUSOnVotMeGvDXv7y+Py4sz4zvibQEm1PJ41467tahNfevtRXbOMUKp9w3ksmI8eGGwQLCfnHfYLDQ8NINA4TEC9MK5rxJL6i8UQ2k8hlq3tmLreVnQJQBlriafXC46E5JGnnN70+k3i+iUVfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VVr8QJQl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aLQRtORwn4Z81DREHqNz24hlSef2b4j4QvU3yCEIhKY=; b=VVr8QJQlihNLmjOT/2km2vBGWa
	R3JnIR4ZWoGdicDd5fkRXfUOmmxc1eO6sCOprGxy7tI5AbwR4AkAvzR1lRTc5Jb1j+5DnxMdDMF3E
	e+ii78DqCuy2e2vBI+M855cU8j/tg4YzwofgnL89c4YfnzS3Jwy6ehBsMyRHjOBO3SYXZPrz12HnI
	C2vo9aac8yojLOm7vjg5EOF8XXs4nDzp323afGeRuKkkwGW+ExA0jaZgbbxVrk963I8lW1qyD72hK
	8EsvRpRxepJ+F/SWbwKlb1tpL3ky35AmGEWWvJkbIJybTIL9c953EWE71N/P01zRPZR99wd4EUAdu
	A6A/F9Pw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1relqg-00000003CFy-1MIV;
	Tue, 27 Feb 2024 01:01:34 +0000
Message-ID: <81c5b68d-90ca-4599-9cc8-a1d737750aaa@infradead.org>
Date: Mon, 26 Feb 2024 17:01:33 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 26 (fs/fuse/virtio_fs.c)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
References: <20240226175509.37fa57da@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226175509.37fa57da@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/24 22:55, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240223:
> 

on 20 randconfig builds (arm64, loongarch, riscv32, riscv64, i386, and x86_64):

WARNING: modpost: fs/fuse/virtiofs: section mismatch in reference: virtio_fs_init+0xf9 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit.text)

For
static void __exit virtio_fs_sysfs_exit(void)

probably just s/__exit// since it is called from both
__init and __ext code.


-- 
#Randy

