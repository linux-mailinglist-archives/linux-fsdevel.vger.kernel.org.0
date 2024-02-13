Return-Path: <linux-fsdevel+bounces-11293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0C852802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 05:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210CEB24A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D851428F;
	Tue, 13 Feb 2024 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGUGC3e7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F1134CB;
	Tue, 13 Feb 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707798853; cv=none; b=L24c9HDA+eKYOEOFyzMmhRRVANXgoOoDyzQnbb0Kj4C/7BwROxh1+0f11kJB57/nvmPEG/zU2+aYQha6ZKP4rDeeSGhuhbuPlutgNENkGO1h40xhkpkSCU42fORy/WzDGHykuWwG+MBtZZhN7Yllnm69IQw7afz6UdIs4DQUoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707798853; c=relaxed/simple;
	bh=KIbzSD+oc/jZIR4jbZWetsO+W0RFfMXzXcK9r5ePxZM=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=chXi7uSKdGpOPUZXXOaPq6mUMliVtejl84XQmwxzZ7dAN4JJhT6kAZ3ZegtPRrZ+A2rZjSfF5vp9fKcapbPpdF6WJF3XpiZwgbi0qEF80Hk+DuRwly5trg89ZOjSXdS5RdyWpiZFViWp7O/JlieEpgoFECxP5ONNwV6ji4kWIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGUGC3e7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6de3141f041so414439b3a.0;
        Mon, 12 Feb 2024 20:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707798851; x=1708403651; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vh4C2jib+iFDULM0386egKcjhLxfCpsjoM1ZbGOsfWA=;
        b=YGUGC3e7gHJi453vF63ASpDBgZnQ8VkznsCAeTTe4r8FIJIY1O97zoJHUfZcyyBOll
         moLILL5fTExbOEGxwED3ABhGxEms3WANvJkh8OuuxF7rN3hVRSFfE2oj22Iz1WGMz4i7
         auNwXG8Z/QgtlxWQPVzdYYft37zYxOlwMwlX8Xcc45NkM8cdmhnVmnrdvXU+nm5shhDj
         zzcgkuwoP0GXPgnXQTt9VDbNNARnfY9lCGAZthohBad8wXBjoGp6KzgZEc6kaAyudEcX
         5lpfOcr19+X1rwCZT5odiiPtbBF+uPET1oqlmNA9yatxkgHMwv4sUEPTV3MUMMMbn6L/
         3clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707798851; x=1708403651;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh4C2jib+iFDULM0386egKcjhLxfCpsjoM1ZbGOsfWA=;
        b=mhkOUjj3ZrPWB+jKXN/tWUu0136m+Y4pYHaiR9Umna1uqv8t+DlQi/2m04rpgRxpIo
         un9g9/gnO62UCC+rU9wuzk7jcjZBJRrBEGjj1kMUfnzv0VUaLXKYDcX37gLU0XY0Bayi
         0VRvCLkYJW8yj3TRehcs30gNXaL+8dNdk9xNMMcW/0myAzx4RocSqoyjSn49PgvPQXyx
         PlsOx8HUBCeOoaZN/oriM8jXXV2At5rmbJ9ViykA2PqGoI84xJlrj+qL7nHGHr16AcnO
         NMB8fYMziyaLt7aRfZ6nqIFTa+QICHBMbuvMFFhVxBx/Cph4Jvl0NI6DXvnX7VX7YSrQ
         ErYg==
X-Gm-Message-State: AOJu0Yy0N7M4mxlEIqv1s5CMd54oSn4+m0IAFHfzzan3d/P+rE5uaat7
	o0hvTQRAiIxv1k8JIQoqsGklLBxQKtJCPN+tXAYF36syQPlH3C3XfWwW9T04
X-Google-Smtp-Source: AGHT+IEadwOvNzG1cYp2wrNwMifgYz/Nkf//UbAYKYK0dIw3gZ4koF9PqsM8/TaMWNQgSlkRINCZ5Q==
X-Received: by 2002:a62:cd89:0:b0:6e0:9e90:c952 with SMTP id o131-20020a62cd89000000b006e09e90c952mr7886741pfg.15.1707798851203;
        Mon, 12 Feb 2024 20:34:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU0RRdBzarrpVcyDWdb8qRYiHJCCqDXh7A8EViKwnWbqKgn+cBFmAQ4jjKcD0C28Sum5Pyuou3F5mqUG+7Qq4/RYaZn+oZSZua89jrFTzI5/T0etWXq1UpNMje6CuIZpqf1Mw+guISstQ1gwZtrvK/HmrCYTnhTVUX4XZCdNvByS5VDb+JVZ+oQxRYP1muyGziTpF+SGVhnleo01PiJ8JMIAYm3oM0mzPLN7t1cpS47Pd7bi1LwAsP2Tyw+6xk9EfHo3AsfkpFjmmIzXp2kEJHuMASP0J7sh0gvlkFXxYqD72Z5ilbkNVc6RReAhLondBt7JaD/PHpDqKLFP/zWYjk/NJK4+ICX1pxJZLVw85gIo74OjUr54nWasmb7lUh5xRM/NOEFUNqKPX5DjvJBzKc3rvhtUPHnqVFLQlOPAkdl2PXMp5lpUK50d8y/NQ+XWHhIqJLOH77s3jlswpsTaPK7tZ6X3cCk9cvtwFLxQT7sV9mvf8Bl7G3U2pJnwOVW6tUmYs/CXoCGk/XPk/G/DO6kQx4Pot8TWso71UrckumNkRwjZRxonNl8EFQy9dg+rGOltEj7tTV417ThWduaqjOwooBCyH7crro+AoUuSvSLfnxl229YnqoYF0nmlV5xlnD+eQXx7QC48wS9P+ccOaecRsP6vvd/xvfaA==
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id s23-20020a632c17000000b005dc816b2369sm605121pgs.28.2024.02.12.20.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 20:34:10 -0800 (PST)
Date: Tue, 13 Feb 2024 10:03:58 +0530
Message-Id: <87h6idugnd.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 02/15] block: Limit atomic writes according to bio and queue limits
In-Reply-To: <20240124113841.31824-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> We rely the block layer always being able to send a bio of size
> atomic_write_unit_max without being required to split it due to request
> queue or other bio limits.
>
> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors on the
> relevant submission paths for atomic writes and each vector contains at
> least a PAGE_SIZE, apart from the first and last vectors.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/blk-settings.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 11c0361c2313..176f26374abc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -108,18 +108,42 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
>  }
>  EXPORT_SYMBOL(blk_queue_bounce_limit);
>  
> +
> +/*
> + * Returns max guaranteed sectors which we can fit in a bio. For convenience of
> + * users, rounddown_pow_of_two() the return value.
> + *
> + * We always assume that we can fit in at least PAGE_SIZE in a segment, apart
> + * from first and last segments.
> + */

It took sometime to really understand what is special about the first
and the last vector. Looks like what we are discussing here is the
I/O covering a partial page, i.e. the starting offset and the end
boundary might not cover the whole page. 

It still isn't very clear that why do we need to consider
queue_logical_block_size(q) and not the PAGE_SIZE for those 2 vectors
(1. given atomic writes starting offset and length has alignment
restrictions? 
2. So maybe there are devices with starting offset alignment
to be as low as sector size?)

But either ways, my point is it would be good to have a comment above
this function to help understand what is going on here. 


> +static unsigned int blk_queue_max_guaranteed_bio_sectors(
> +					struct queue_limits *limits,
> +					struct request_queue *q)
> +{
> +	unsigned int max_segments = min(BIO_MAX_VECS, limits->max_segments);
> +	unsigned int length;
> +
> +	length = min(max_segments, 2) * queue_logical_block_size(q);
> +	if (max_segments > 2)
> +		length += (max_segments - 2) * PAGE_SIZE;
> +
> +	return rounddown_pow_of_two(length >> SECTOR_SHIFT);
> +}
> +
>  static void blk_atomic_writes_update_limits(struct request_queue *q)
>  {
>  	struct queue_limits *limits = &q->limits;
>  	unsigned int max_hw_sectors =
>  		rounddown_pow_of_two(limits->max_hw_sectors);
> +	unsigned int unit_limit = min(max_hw_sectors,
> +		blk_queue_max_guaranteed_bio_sectors(limits, q));
>  
>  	limits->atomic_write_max_sectors =
>  		min(limits->atomic_write_hw_max_sectors, max_hw_sectors);
>  	limits->atomic_write_unit_min_sectors =
> -		min(limits->atomic_write_hw_unit_min_sectors, max_hw_sectors);
> +		min(limits->atomic_write_hw_unit_min_sectors, unit_limit);
>  	limits->atomic_write_unit_max_sectors =
> -		min(limits->atomic_write_hw_unit_max_sectors, max_hw_sectors);
> +		min(limits->atomic_write_hw_unit_max_sectors, unit_limit);
>  }
>  
>  /**
> -- 
> 2.31.1

