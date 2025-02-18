Return-Path: <linux-fsdevel+bounces-41905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D5A38FFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 01:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C84D3B2C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE983EEC3;
	Tue, 18 Feb 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="k1GS52qJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B5C8EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839169; cv=none; b=H/WVGlD0D0NezH8L6rtlKelibDOxqlX0hOcqz3yy5z4bOS6W+oMrd9EC9SUJpFnK257bJE50YaJON7Q8J4I2VDFm2JbjigAADT8QqVeT3fauaeiEGUvGTtLvxYwX8kD3tjTYYTAXtIxlJxuwCE8K+WrmQSt9EKPFBG+RdNEzM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839169; c=relaxed/simple;
	bh=kkCI+MIWkW4j32PzOZgwC/VBvKTSy5hkrZazhISQnyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIB0NBQyITP3s9ymDG/h0qbdAS1Q50zAnabTtcoU4qalyDEy86H4HXg1+EAzo48CZANWnCx6GObkNUkVMQ9oEOdchCJI1OCUDctAUtSACslHf6QgUY3Mnryqo3REdhjmolUJMB8yxUOR8msHbRvSsd3nO8BMnOtNNXnWFX3hBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=k1GS52qJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso9073165a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739839167; x=1740443967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=De5WQOe6k2skbiipS+ducGoEsMfnwQochicbgjZO/bs=;
        b=k1GS52qJLD7N4uAHd5fk/ayrA96CBRnX5ctEd2XqncPJyMjG7587yJlJxkyClL4HLN
         HzwfOUsOg9t9IHcIdhaTTA0BuMfd5bQu+4HBfFl+kg4OjV1M0h6ewm9/Cn5KBDqK7Y7O
         5oaUV7WWs9iHTyXz3FcLfboRrPQIT3u2ouZbVm9RdzN/7wJIpPdZKHbpO6NxI7xvAq2k
         tkf0WnPYxcRIiQb3wv3XaBt9lQ7bRFsSa5uvViu0RFfChvBExBkojtRlqH8l+6UW0Dnx
         yj/zDid2x5nFHo0zJHZXfD9Pex2SFAXJUnCpUdnQK7CFy5CkYLTEgXyhVY9sBt28ik5Q
         ECVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739839167; x=1740443967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De5WQOe6k2skbiipS+ducGoEsMfnwQochicbgjZO/bs=;
        b=H1G1nNMi7h3km3tr4gx64EwUp6rTMP19Ar9DLWuw4hEQF4aq/EGlaiAFEhDivMnQAZ
         hsbRFsS15BHPiuD5phFU/vFnVdHjGkGOGry2xRahNeCi+aHrs+LC7L99xBxPcIo5d4NJ
         OKq9M33MGo6kj5/ZfexZ2wyenCfp+s8hUPWeV2w2ymAHZR+6oBKmYZr1GxwQaGo+BxUj
         GizQiv/zKCN9uPaugUpPLgY8RC3fhBIn64t7d/rZIQ9Qy2qX4Wc1ODYlGoM0tjs2VOjE
         2v0dRj8crbLsf8DyzahzfoVhbsuf4QfPEEQASenMXzVx/xUQrNbuAz2tXKShAijlxhO3
         ZQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv61R2b5XtSj6Z3LrrmonniTQAsxRHTjPlDBCtUfXi2bSAYJmAtirgOxQWzcaL+/yHJaB6CxjCa17f4kcO@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxLjniKVcy+pmRg11qVMS69dAyGIqZlrCiH8veh6AtNZNuMPT
	fcCqh5SznCCQdN6CY+0gfdEfVcIyQmZEgLHSXbSbZwb8fbtk7YY13VfNmjyjbXM=
X-Gm-Gg: ASbGncsVqz3WKaNbij5x+QNjQxQfAkT5jfzIdVbaVZ+utfgqh6yaapxgc37Eg+SQ0Pv
	7dDUzThjboSX0vU+ltX5PvM4MVf3Np8iIj3FLClZpvXOjySSx6wV5bgSt6X05dG1BTxW9qk6EXT
	aM31MrF4aYHBC8lvOihC9AT2WI1Kq6MnpGle/4na3+dKvpZwRi57r1YbASIQdiUqSIHwweIgTqV
	8xL8MGEa9/9LX/6gm+IkIh2s9SvQDCzCizTnJH01W8eVwHoNWsjjKnwBlorsFBdZtwaIWEiv7hX
	tJVqp/mH4d7LnYgM3uzSWqPcejAHyXnsNlvTsD50jaM97yqEZpGFiu1NTGoV43KhlP4=
X-Google-Smtp-Source: AGHT+IEeMGa7xPwEtMlpXZafvTTjPq0Al51DL+lbvh4II9Auk36aN41MyoHA6pK5zQJ2LCv7QhzaMA==
X-Received: by 2002:a05:6a00:2d9d:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7326177e484mr22261738b3a.3.1739839167098;
        Mon, 17 Feb 2025 16:39:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568961sm8750148b3a.38.2025.02.17.16.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 16:39:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkBdz-00000002bHy-1hQn;
	Tue, 18 Feb 2025 11:39:23 +1100
Date: Tue, 18 Feb 2025 11:39:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] vfs: export invalidate_inodes()
Message-ID: <Z7PWuwQApEWI8b06@dread.disaster.area>
References: <20250217133228.24405-1-luis@igalia.com>
 <20250217133228.24405-2-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217133228.24405-2-luis@igalia.com>

On Mon, Feb 17, 2025 at 01:32:27PM +0000, Luis Henriques wrote:
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/inode.c         | 1 +
>  fs/internal.h      | 1 -
>  include/linux/fs.h | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 5587aabdaa5e..88387ecb2c34 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -939,6 +939,7 @@ void invalidate_inodes(struct super_block *sb)
>  
>  	dispose_list(&dispose);
>  }
> +EXPORT_SYMBOL(invalidate_inodes);

Oh, I didn't realise the FUSE core wasn't built in. That makes me
even less enthusiastic about this....

Ok, if this is going to happen, you need to pull in the change I
made to get rid of invalidate_inodes() because it is now a duplicate of
evict_inodes(). evict_inodes() is already EXPORT_SYMBOL_GPL(), so
then this patch goes away.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

