Return-Path: <linux-fsdevel+bounces-22119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72769127BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8628ADD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761602BB1B;
	Fri, 21 Jun 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yCi9RXcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7CD208A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980143; cv=none; b=iSEFi8xwRyZ5YZanBZrCn/rEGDEQy13TESAWXFfid90BdYByH071ssvmcZWqLwBc5D9knL0ymN0gHuRVq5JZQAFyY4LSEoYSiP0chevHxgVWoeXOHBtH8DZqPAqp1gH2sJ2dsIOGMUhqbMFMWVoLRdP/fhPkBWHDNb5ad9YeaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980143; c=relaxed/simple;
	bh=56Fo7ge/GaJ7kRUMXWtKUYd2boB/qHndzM21h2jkuTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfzSek3dly8cG5O4O46P3zvYpC/mHkl7Lf/s9ey3aAm8uXnYNOG0tUQ8l1EGGN1KLLpSJIA8VTOAZ/MnNV5S1eFJZb+JBXuDVucA4VnWwUGvo2xbA8uVQfX/o6Z38tG2W8rQsnAGAD+Q0If7sUsDdLAu6NPhg/WBliStFc2NDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yCi9RXcW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b3364995b4so386879eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718980141; x=1719584941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1abM88BFe0lQRCbOZswUBP4pTWhgX2789Hxz6HQAYw=;
        b=yCi9RXcWgPY73DTL0zaUltzOAbDSfPKRJzRtIzYuK08oTRM/DRLHaGs40qsavXAPMK
         1L/oa52C+KHCoQmof6nrEDFJA3c+z5Dn8CmCPLZ5a0UNz7BY13/Yd5bmIaYI/RxzEskS
         OC71P5Yldvz4O/Sw1sk58usICH1NeLiWdCYyREGRYLB2tvVxgN61VFyJgLiGxj+iPTVh
         /zb822P4SfmTLKk5echBzTRL7mtzEX1lO9Vt8AUhARrnKH2w19QOXlbysljqMFXW1Zxy
         s3kRSUKphl+I5f4a9RTU5mpkTxEmaKVjqR4X9PcysK7yNwZU2N35JqaS+/2EHJ1eu/9J
         q4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980141; x=1719584941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1abM88BFe0lQRCbOZswUBP4pTWhgX2789Hxz6HQAYw=;
        b=ebin8tZ2IJ0e9Ni9/A0icPH2Ct6fh9Yosez8nHyfz7eob6R1c+wsNnVuTeBgEDpQyI
         GyX39LJnnxPs5gHEXsV/9dB5HrrVKvSzuVdiUnGGZdjFfMBpy9Cxd13mZGS/ve7VO29N
         z1TYsCJVCgMa1C3Pvb+BO27qWY8+9l0PzAMbldVFZ6JMujFq5qdEqIuC0P9/28md7KrE
         cDVA10WrIAFsIT4ORzo7Pm19MXfalGdPskrnTf1Iq20v8A26mUXoSMu20IQw61fNEr+y
         YhVU9JnFhcXAdQCX6nJJOEUfGh5VG+I/36phoJryxhfgG8y8fyT/8Hl7D9BGRbxL9tO4
         JFyg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/9T1c/VzPOVAH/Zmf7NkJXhApdm5eLJsCQwoxnCiYYpRNRd6FlcYrNzz8qOdoi0/t7lsmi+oMLFEku8vESQE8VLlDH13NnG9sm1HvA==
X-Gm-Message-State: AOJu0Yx7v7OtP9RiYRHjgJltg6cZHx8T2sF9Mjo+hlD9PdfGrXzs93gV
	+OFP/O3MMSeSivmTbLRZrKwcpoV20hQtSNgYdqaTPd8GbgQt+kSw4AYhlym5F1c=
X-Google-Smtp-Source: AGHT+IEkuinnMEokNvg2WVwEkTmhWFZmN7sgYIOaiINLiCcfmqVoMGTXiCo/a5mwW2DIZdGNohN5Wg==
X-Received: by 2002:a4a:c60f:0:b0:5bd:af39:c9d9 with SMTP id 006d021491bc7-5c1ad9093ebmr9612314eaf.0.1718980140889;
        Fri, 21 Jun 2024 07:29:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d58f236fsm276528eaf.37.2024.06.21.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 07:29:00 -0700 (PDT)
Message-ID: <2159f1ad-98c0-4a71-acb9-5e0360e28bfc@kernel.dk>
Date: Fri, 21 Jun 2024 08:28:58 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 00/10] block atomic writes
To: John Garry <john.g.garry@oracle.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
 jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com,
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 hare@suse.de
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <171891858790.154563.14863944476258774433.b4-ty@kernel.dk>
 <674559cc-4ecf-43f0-9b76-94fa24a2cf72@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <674559cc-4ecf-43f0-9b76-94fa24a2cf72@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 1:59 AM, John Garry wrote:
> On 20/06/2024 22:23, Jens Axboe wrote:
>> On Thu, 20 Jun 2024 12:53:49 +0000, John Garry wrote:
>>> This series introduces a proposal to implementing atomic writes in the
>>> kernel for torn-write protection.
>>>
>>> This series takes the approach of adding a new "atomic" flag to each of
>>> pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
>>> When set, these indicate that we want the write issued "atomically".
>>>
>>> [...]
>> Applied, thanks!
> 
> Thanks Jens.
> 
> JFYI, we will probably notice a trivial conflict in
> include/uapi/linux/stat.h when merging, as I fixed a comment there
> which went into v6.10-rc4 . To resolve, the version in this series can
> be used, as it also fixes that comment.

I did notice and resolved it when I merged it into my for-next branch.
And then was kind of annoyed when I noticed it was caused by a patch
from yourself as well, surely that should either have been part of the
series, just ignored for -git, or done after the fact. Kind of pointless
to cause conflicts with your own series right when it needs ready to go
into the for-next tree.

-- 
Jens Axboe


