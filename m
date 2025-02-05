Return-Path: <linux-fsdevel+bounces-40902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED5AA28547
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 09:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90159163580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5643229B02;
	Wed,  5 Feb 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9bq8i/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC52139D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742717; cv=none; b=d+eF6LBK2zmoxH4vDnq2jwG/kwM+fKlRMkKFeOt79rqaOuQVwym3KrsxyYX23rHmgUatqu85VBOgtaXbFvEeLHepcbFCvCmAW3DibGw5fbTYsz5Z7465QmgxZES3SP/sbLN4sosOOyeVmDKVeh4Wohb0QqTneKSlBPs74k4sg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742717; c=relaxed/simple;
	bh=97jVGhCDjcTDVbVivTVSkH1MzDobQI1C9U3qe9p/JdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPS7IfWkpOUN5kg4CQGkz5DiB9wtgqLtqALz+va/5P9xwk2FOqYJbs3gKcvQj3EduLAT6epJykabB9f292GtgFeUdPMcPgBdEecc2zGn7rbOyLFybQrZFCR+nXHjafjKu9l6kxAzvav7L2HggRdUfcS3OvduaS85DpoQCzhAebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9bq8i/w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso128751166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 00:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738742713; x=1739347513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdBUtPfa80TdS6XsCzHJbO4ZnrPPqaGCk3IbZRYrSYM=;
        b=S9bq8i/w8g0AXvaxdCSZQ5EThWR7YWKhGYYUVVT5jZkIpzoy1Vnpbd1hbyXokGsehd
         0S7cTw/Ab/JtrS1W1EXdz6I0BjmBNDANBuwZhx1o6ee1IkGKhVy1VQjI4sZMSjr9SQb9
         IBrXbUA+HovB0Qap31Sc/z7ybJPnoqXSdOE7d6GRxSzBxBdMpH2tU7lpwzkqDg0KJu7S
         CDktVE7BNhRxfMFSExqG6g81o9gqohWEjZzz5fhgHKYaOxy6bM1M09htLYmt2BvmWibt
         xG3BJraSepFgWQBcvqO7SEVNbY3cU3Zm73MHLZUJtiX5skqS/poG/Dr2VfvdXZD6Xigd
         SA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742713; x=1739347513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdBUtPfa80TdS6XsCzHJbO4ZnrPPqaGCk3IbZRYrSYM=;
        b=tK6fAYUewjLqCvnpOjA32JfJzZI0w/wLnl/zjozP74V2dYx7szRsphAcnmk4L+0ao9
         pWqbpnZyOyq0or4oEPqaSdTGPAun2dk5CpiYhfKMOTb+E50bFB+hD5AY/0ERVk9F1b17
         eFzb9EbpOJ1Wun1mfTobSR/Fc7w4zeuE+kWnBbrEA9Ar5bc+Jrg8pAhIgqQTNr2UEIs3
         OfybCares6eoNSPY7arOQCihSjRIZezzcsGG/6v8Hkv6Ev+LlpkEEJ0sRjE5pcD8kVzp
         ULlS4H2NEEgfGrwRG9WVqNhKYlW9CxK6cfRQP5W2EeGERkz4LXme00KXLrdKw5RArev0
         dg3w==
X-Forwarded-Encrypted: i=1; AJvYcCWhwknGgJ5RXtFQfXRZLhgtL+FaSUF+JxnRFsE6N2AUBqTj2loQHVY9FPKnfSyt+H0tRCRXjx6/bX7kwSjv@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxjB2XWATrVZY+bZpzo71MdiCWeWiJ9sFUVillAL/g2rH2lnr
	05UWGOD+ydSljVssb1KI9yMiK6oQJsbVd/zBk22HHMVNgnehdbb5
X-Gm-Gg: ASbGncuSb5A3c036MXCgdBtCDNycMakv5gVX3ZJKr2Z5R0AHTq22Kb9TtRi6CMpoG8A
	BKFOnvMEIsjG2Jmv7JsourVdVZW8z5i1Qcr6OS2wbMcpKNX6jGITyUC1zJPQOjsZlGqwdYqmlSX
	GvXCkpiDygueOkfV+CQ9wAsPVPSF997PxDAqKgTI11EeRV50GFRD9zHU5FYenLLTrHLR8osnbVR
	/Wpcd6yi2/hxecUBuoIZ0G3MVyo78UdejA++m1zVqjJh7fiNQb1aA2RBK3UDCwMglOmPg16hhpj
	s7zFhtfUROz2ek2ICvLVZQ==
X-Google-Smtp-Source: AGHT+IE60i4IhEj5X6e+4i+9SGu7k0+YTexJl0yUgqybIgujerZhwV9N39xW5XxaT+8kzgcyUNyAKA==
X-Received: by 2002:a17:907:7f0f:b0:ab3:47c8:d3c6 with SMTP id a640c23a62f3a-ab75e2102b1mr193810666b.11.1738742712584;
        Wed, 05 Feb 2025 00:05:12 -0800 (PST)
Received: from [10.22.224.161] ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f1e23sm1048060766b.82.2025.02.05.00.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 00:05:12 -0800 (PST)
Message-ID: <64ef645b-4d7e-4eb0-a497-0b24e90c225c@gmail.com>
Date: Wed, 5 Feb 2025 09:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, Zach Brown <zab@zabbo.net>,
 Christian Brauner <brauner@kernel.org>
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
 <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
 <cf648cfb-7d2d-4c36-8282-fe3333a182c3@gmail.com>
 <Z6FxzraXgNYxs2ct@dread.disaster.area>
Content-Language: en-US
From: Ric Wheeler <ricwheeler@gmail.com>
In-Reply-To: <Z6FxzraXgNYxs2ct@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/4/25 2:47 AM, Dave Chinner wrote:
> On Mon, Feb 03, 2025 at 05:18:48PM +0100, Ric Wheeler wrote:
>> On 2/3/25 4:22 PM, Amir Goldstein wrote:
>>> On Sun, Feb 2, 2025 at 10:40 PM RIc Wheeler <ricwheeler@gmail.com> wrote:
>>>> I have always been super interested in how much we can push the
>>>> scalability limits of file systems and for the workloads we need to
>>>> support, we need to scale up to supporting absolutely ridiculously large
>>>> numbers of files (a few billion files doesn't meet the need of the
>>>> largest customers we support).
>>>>
>>> Hi Ric,
>>>
>>> Since LSFMM is not about presentations, it would be better if the topic to
>>> discuss was trying to address specific technical questions that developers
>>> could discuss.
>> Totally agree - from the ancient history of LSF (before MM or BPF!) we also
>> pushed for discussions over talks.
>>
>>> If a topic cannot generate a discussion on the list, it is not very
>>> likely that it will
>>> generate a discussion on-prem.
>>>
>>> Where does the scaling with the number of files in a filesystem affect existing
>>> filesystems? What are the limitations that you need to overcome?
>> Local file systems like xfs running on "scale up" giant systems (think of
>> the old super sized HP Superdomes and the like) would be likely to handle
>> this well.
> We don't need "Big Iron" hardware to scale up to tens of billions of
> files in a single filesystem these days. A cheap server with 32p and
> a couple of hundred GB of RAM and a few NVMe SSDs is all that is
> really needed. We recently had a XFS user report over 16 billion
> files in a relatively small filesystem (a few tens of TB), most of
> which were reflink copied files (backup/archival storage farm).
>
> So, yeah, large file counts (i.e. tens of billions) in production
> systems aren't a big deal these days. There shouldn't be any
> specific issues at the OS/VFS layers supporting filesystems with
> inode counts in the billions - most of the problems with this are
> internal fielsystem implementation issues. If there are any specific
> VFS level scalability issues you've come across, I'm all ears...
>
> -Dave.

I remember fondly torturing xfs (and ext4 and btrfs) many years back 
with a billion small (empty) files on a sata drive :)

For our workload though, we have a couple of requirements that prevent 
most customers from using a single server.

First requirement is the need to keep a scary number of large tape 
drives/robots running at line rate - keeping all of those busy normally 
requires order of 5 servers with our existing stack but larger systems 
can need more.

Second requirement is the need for high availability - that lead us to 
using a shared disk back file system (scoutfs) - but others in this 
space have used cxfs and similar non-open source file systems. The 
shared disk/cluster file systems are where the coarse grain locking 
comes into conflict with concurrency.

What ngnfs is driving towards is to be able to drive that bandwidth 
requirement for the backend archival work flow, support the many 
billions of file objects in a high availability system made with today's 
cutting edge components.  Zach will jump in once he gets back but my 
hand wavy way of thinking of this is that ngnfs as a distributed file 
system is closer in design to how xfs would run on a huge system with 
coherence between NUMA zones.

regards,

Ric



