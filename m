Return-Path: <linux-fsdevel+bounces-58078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE8B28EB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2E1C28324
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8926FA4E;
	Sat, 16 Aug 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkL77OLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F62E8888;
	Sat, 16 Aug 2025 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356428; cv=none; b=LdoqxFmnhdKjyTo0Guzlm09gZfJV5UkiRKKFp6B2m9ybdghT9+rGn9rPUp/WEz1xzvFkm6angdgdSDSNe7kWqEOKMm5YeHLINRO9qiMDWYvtM2EjS7MPwurzagKznFgbr0Q/tUSedNDBcTjrJMvX5DlXEOV3uR2xx9+setWkKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356428; c=relaxed/simple;
	bh=VigReBL8M6MI529Z8Xk8Ix7rUQBlX7NkF4iKwyADbaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5ijLIhlLMVGJSGaKp2pLMzjJljEsU5Ukty7swrVFvGRZpCNieycy5gz4grA6MhsjjCZ3YU89kll7Sr96B0zeOMbDvvXveunNdJaolTZhCSTKfyMwohEY+nHoE3nfgiLIGtw7rigQV8fOFusOXbtrPLC021sk+YvEwG2IUXvEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkL77OLk; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74381f0664fso726846a34.1;
        Sat, 16 Aug 2025 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755356426; x=1755961226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwjPbg8KA3rFGnPGiayWOqsstlBug/9B8GI8n0PblXs=;
        b=UkL77OLkX7p6VannEj3vOtKP97PuW9J4n3Zu7493Dhko2jD9zwElp+uOMs8TKqexwp
         WLXQyvtHiHV9wGaehxDVSBvPgXIVVXc0uRw9Ne6vF/bPYibJSW8STbUpwvm+BZm8JirG
         b7eziMbpCzv9yNv3aWikd6UxdMiYvNs8VLUpoevV7haf1LVwbtLX/5pSAsts6Ms2Cnec
         ZiarLkZ4al0KPa88wAO9mYNkhzRX0rn+LTkXJsfhFCkLDqBNbET+p69SF8rsrhAWfPHC
         Yw8psL5p0NZ7LGRHoSBTEzySQYHZNy/dmqWo3yPGr22pJQ5dJKb7tbbQXf6BzK7AryJ6
         54EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755356426; x=1755961226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwjPbg8KA3rFGnPGiayWOqsstlBug/9B8GI8n0PblXs=;
        b=grMWlTnfJcSpp7q+qKC6mjQ9ediT5hWQVE8pXmTOZUuhGtxCTLhBw2mr+XedtD/Ca7
         Ynvy9LhWWMC2wTZSYiupI5eSYChYWaMKpQUVryNC+Ywe8XvR6Q9+LMKJsbNu7XD/x91l
         GvLDd/Sl6fG6BUofQsFUta63ETZnuNAdoZDu1z0+F4aDSe3sD/uml2gzCwFsFlbmiMlb
         qWDNGRiozZXtDj40EoJmyQu0m6ATHFs6Q4OQJcKLg5st3IpREOgSBNQuXgRwDMsWEjjy
         cVG0/b5TcJQfuSvzlTGwY0L7hHYTzESlipN0PDw+mnLn26QssV12N/AtWBSqQQY7INRR
         l6/A==
X-Forwarded-Encrypted: i=1; AJvYcCU2iMlm4+lBuSR5g+m5oxfNIWF9E4dNrOs1cVMaWs41nx5/pPX5QlpZznWoB3rhxai2xQF2qy6XnW0=@vger.kernel.org, AJvYcCU33Rl/eYYalb0aB0sLnEhyKO4cKZgOq295cD5YT3yjkV3KmvGe7EZq35MZO/5G6sJC6Kl1j5M7mHJGD6EVGQ==@vger.kernel.org, AJvYcCU6j2tRC/QtR+qODQ/SQH+l3wHcyUaEnkuIuKvFxrUV+I9ThtZ+0tvGUBh0mLiOHRrj7wHk6HLIrxME@vger.kernel.org, AJvYcCVWrt4BDTGIy/SuFzLC3NyykpXiomaAxVSyC16AOKi3D3yjVmpUxtsj3xsj2ElEz5xe2ue33mEwfCQ+WoOX@vger.kernel.org
X-Gm-Message-State: AOJu0YzqV5L9ULYO+g54J/QN0Hot/OKvxtYPYC2w+8aC4OM/SxEn+QIN
	NkuzzIVUjc/bGxL9GMfay/pqiTAnO4noyRMfDT1vFzVrxcmuuFcPxaexV4amR1af
X-Gm-Gg: ASbGncsKmmcHMB8RWk8DHqqNwhYl6sZP9QAEpCj3OoFQSvr8UR1/NBveLnLPy1HlpqZ
	UfUkTXY2p8tlsO+IjXbOm1gzLgu9LtwvvHvhMNg66N6iV9JkUBizPyAPN5ptq+z8QLsl4RbDfC0
	B5h0kbvuG83hd9D0XUxTF0x0VT4d3FIyQb8zS+fXsZ7teBOlWp+p9U4FwyTu5mMI/GlRMeUBRXC
	mkh+9KKBFl08Czia9zN72Y+82ZYqc/XgodRbLSWZB/bLvyJVU+1XXmVKCe9EBB7PVmtfojzEwEU
	qYU/l0IEORzq9qmFG3Ub8p7NTwSE4kPlqJasEoNtJnmucHEbZgZfCJUU8cu6kmDX9f2srMWxCXu
	D2n9kjDGlq0YWYEVpK2irY1L8mz17/viiZ1DN
X-Google-Smtp-Source: AGHT+IFFQO6oO7eKhRJoor1ccKngWoereGVcBCKxuKO/JrshNXE7oZADMU90CYmE2ChdFmofXtpRPQ==
X-Received: by 2002:a05:6830:912:b0:731:e808:be5f with SMTP id 46e09a7af769-743924f57b2mr4023050a34.28.1755356426238;
        Sat, 16 Aug 2025 08:00:26 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:1d43:22e9:7ffa:494a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74391bd220fsm881978a34.13.2025.08.16.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:00:25 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 16 Aug 2025 10:00:23 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <a6smxrjvz5zifw2wattd7abmxhsizkh7vmwrkruqe3l4k6tg7e@gjwj44tqgpnq>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <20250814180512.GV7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814180512.GV7942@frogsfrogsfrogs>

On 25/08/14 11:05AM, Darrick J. Wong wrote:
<snip>
> It's possible that famfs could use the mapping upsertion notification to
> upload mappings into the kernel.  As far as I can tell, fuse servers can
> send notifications even when they're in the middle of handling a fuse
> request, so the famfs daemon's ->open function could upload mappings
> before completing the open operation.
> 

Famfs dax mappings don't change (and might or might not ever change).
Plus, famfs is exposing memory, so it must run at memory speed - which
is why it needs to cache the entire fmap for any active file. That way
mapping faults happen at lookup-in-fmap speed (which is order 1 for
interleaved fmaps, and order-small-n for non-interleaved.

I wouldn't rule out ever using upsert, but probably not before we
integrate famfs with PNFS, or some other major generalizing event.

Thanks,
John

<snip>


