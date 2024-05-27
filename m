Return-Path: <linux-fsdevel+bounces-20196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29678CF711
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 02:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F3B1F20FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 00:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE44A22;
	Mon, 27 May 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SK6lhW9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8811FAA
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770934; cv=none; b=aCQihvHdfNJVael74jfgVA4IE+3jfRSyz11mK//1Lr0AcnVFtwUldiHD7S5KNIcdlR0j9thtLwvt2XK3jZHmlXGmkAjiAIRuWAy9eS64bKeWrTHE+2Ro5+94IXvID8Li88hnBIQpbpQHBQtsCHOZm7asOU3BHm8h+l6mlpqcABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770934; c=relaxed/simple;
	bh=hioMBOZdyR1QV8XdN/+RNK+wt7kZa2b3j/k6NWmv97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkBICKJR47m586j9bU9wu5cMEHdS8uhm62rS7lkDPjoy1CSb0/4M+rWuFQq0MbvQxudl6qBNfBaN/j+OuRZTgmZ2/nUYvZ2CjFafcUdvyQhizLzW6Lz4xkJ4GejXIx//gMczGNirHcwDW1hyO2TBbqFbh27tq2N7GnvnY0mh8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SK6lhW9A; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-68195b58daeso2010145a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716770932; x=1717375732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuaJD1aUatqwF4qjWia2A1AlcKfhTGao9KmR227W0ZE=;
        b=SK6lhW9ApZC3MSgqUOYeJL/b/rW1HH3TTOOg3btgc4vdqymNvrzypYfjpqD8XZTJFU
         SV2didnjIQI528ApqLV9YP/D2HU2dVx4gogIHXUoxDsNwPeC2ILd2b3dQHW0GKv81RTz
         5quPnGBOnmK46QyaHlksEqU7s1mdNk4yS2AukTatCIBn0JYJTVJAiipy19/Ty72zgH4t
         esQOCSWDdCinoeTySSEPwON/aBBwgAJmp8NBsD+dP09JGV4vVQRV/xSVgH0c1rLoRfPV
         /M76k0SSGNKO2yYcTZ6j8HDaG4F8iHouKzQ/5El3N6Zs0IdQF/gyftaO+bqLsHgoIimX
         tS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716770932; x=1717375732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuaJD1aUatqwF4qjWia2A1AlcKfhTGao9KmR227W0ZE=;
        b=RI/GDE4Hk+kSNNt90VmlPMBn4PoLpEhEWeAXedIOeExRlRRLPou9T8OVb1TgcJeilD
         HrBLDUganlIN9Fk9B/+2VJflemoeIaf/XD0k3VYllG33AxClg0p4qLopeDiqkGqU/wXj
         uBu7XcpZ4tgJnFzGTohevGqlAkegk85+104CrhfrdZRV+u/lxcn9Jd2h6dQWF2SVv5NC
         K0qmkrbKJ7s6hhj9wuxjBSl2CCDkudjjPXmy9BqQXDSPC+18ZOW+VZNSuXm+HOOd/aHN
         24skCeeHD56vKKCQ50E6yxK8vqvXVmMe6WJk9zJN8/1DS5Umbsg5sDqPLZ3tkhEF6g5T
         Y3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzQ5RheYmchO05Eelg/SFlM6CLybrM5hs/W7lMA4oYPqeApVRUHdUzPiXaQXm33jP05jMGYctlfzcUnf327m8nXRIUVDwrduoNGMK9Zw==
X-Gm-Message-State: AOJu0Yw3SkcZJnABDo1WE1S+GUBObsU5BdXQ/XnrO3yjWWiOSoqmkgJ3
	uCGa8UKu7adaXk8RH8xsFqOgMWt8Klf1uN3AOQfZDk/UgN5haoQA5oG79QijhgE=
X-Google-Smtp-Source: AGHT+IHbQl7/lkOzeGOau08dTp2POnpUQMA13Xqx5nrdWWiCDRBVRFXztGICisDEDkOgIzzbItS24A==
X-Received: by 2002:a05:6a20:6a1f:b0:1b1:e7de:4d39 with SMTP id adf61e73a8af0-1b212d054b5mr8807904637.16.1716770931879;
        Sun, 26 May 2024 17:48:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6fc06c6e5acsm2858016b3a.109.2024.05.26.17.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:48:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBOXg-00Bjiz-37;
	Mon, 27 May 2024 10:48:48 +1000
Date: Mon, 27 May 2024 10:48:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <ZlPYcPLZBh7h9cCq@dread.disaster.area>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
 <20240524-ahnden-danken-02a2e9b87190@brauner>
 <20240524.154429-smoked.node.sleepy.dragster-w2EokFBsl7RC@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524.154429-smoked.node.sleepy.dragster-w2EokFBsl7RC@cyphar.com>

On Fri, May 24, 2024 at 08:58:55AM -0700, Aleksa Sarai wrote:
> 
> Though, regardless of the attack you are worried about, I guess we are
> in agreement that a unique mount id from name_to_handle_at() would be a
> good idea if we are planning for userspace to use file handles for
> everything.

I somewhat disagree - the information needed to validate and
restrict the scope of the filehandle needs to be encoded into the
filehandle itself. Otherwise we've done nothing to reduce the
potential abuse scope of the filehandle object itself, nor prevented
users from generating their own filehandles to objects they don't
have direct access to that are still accessible on the given "mount
id" that are outside their direct path based permission scope.

IOWs, the filehandle must encode the restrictions on it's use
internally so that random untrusted third parties cannot use it
outside the context in which is was intended for...

Whether that internal encoding is a mount ID, and mount namespace
identifier or something else completely different is just a detail.
I suspect that the creation of a restricted filehandle should be
done by a simple API flag (e.g. AT_FH_RESTRICTED), and the kernel
decides entirely what goes into the filehandle to restrict it to the
context that the file handle has been created within.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

