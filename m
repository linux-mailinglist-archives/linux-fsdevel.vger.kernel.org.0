Return-Path: <linux-fsdevel+bounces-39886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57376A19BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D2A188AC0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921F46B5;
	Thu, 23 Jan 2025 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="btnU79mn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE9C2C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592476; cv=none; b=imXcVx1xIk/yKXcZyGfx6w6JcPe8ECLbTunGL8UOXKgUe/vKvzyiUkr2+aW9nbTuUjDKdUZzMRDIbut05CKMB8EdHljWq+A2AgxP5w0iqBbZaZuaDIdgqRyKl0GrMr1CWRjKKb7w9kjyo35tILgaQRAtFJD1matqMMmggSx1kPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592476; c=relaxed/simple;
	bh=bknF+F6hJjkpcpiprBKum1f0ewgxp6jtN6VBf5aWc4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDXrNx52j8wlExDIYjWrX3mgRP6MIARz7cgmVN4h1dGPeAmm0zEtIcjgCfJZLlYH9EeEWR5qj9RtzvIr2cd6A+HhDdVpZHHCx0sZTv3n9B/pSRqyp1lwvloEfP5i9gALVyL5wQyNLTNwIPCRjJhL9SWFYQ+Xj/qaj83UZVVSFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=btnU79mn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso556680a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737592474; x=1738197274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dusBtIDb1zHz9mahnqvDoTZ2ySOe70WADNygx/H3Yww=;
        b=btnU79mnSEmk7ppNSwc5kkEEVa1aw1LwA9i7MrWK9JWGBmZl9NPtR2OHgQ3c5ZdXxN
         vk64MJEwmZ/oCWTazoYaRY7oUQ/fdXA3FlBPX+vKVWXku9188+2+dBS1w79pDCYARRz9
         lo9sejp7MaH1nc8ZH9IOWUuJJzBBsTS7+wrETbnB+NDdsGQArQQFll4lomPLNEEA0DVT
         lR7Rdng2ZOACfLBpzWP2dj9TLl58BIUy/xzNb5iJdwSElVj8fG3t2+NcvihM3J7uhhDJ
         n3IIDwOI+zxIP/cnu6U0q3sYQynkNK1fc9msX9QoQJ1kW+ghJx2CBTIiArk4PZYVpflr
         21mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737592474; x=1738197274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dusBtIDb1zHz9mahnqvDoTZ2ySOe70WADNygx/H3Yww=;
        b=BPVuPi4oeqsoetyXfgePmHEf8xgPl0NUyqurdeivz60ChaVnB561D+7TTAI/+iWK6m
         UjHUsKYf3KGpQ2IjGxj9AKlX+yamblqKWOdKtLGtloBE+HmpTC3oe/GrGuZ1SNNGbE2o
         JkmlWc9+ixds4EMSIVplgcTDWNIFWDjfDqt9YHeNArdf3w3IUa8ZQsGFeRcA+RDPeKVi
         1kjFdTMG1MWQbkKOeqKP0FlBd0y9/sSQ1dl3TRYqFiSegDWMAmf7p6d1CQzyfFAGz9Ba
         No8sVxk1IfC6NE+lcy2JZ3R01DBGSGiRYtqbfdYef93xrb3XDfkW9vRbQysShjCO2f5e
         2V1Q==
X-Gm-Message-State: AOJu0YwOB1BbXICP0C0HywFMozEwtKjVkSNSZdtn+5/h1oGDqr5U/L7y
	/1ZrQ2dXZMEYgxbk9p81TG9F7QOg8ZPLbFbvK6MuZX0lQT+hJGKEaT2YcxQwRqs=
X-Gm-Gg: ASbGnctmEUAWpOa2r5vvCchU+D4cDeRX9MRMWhEyJwMcyvnEtnCxNQ6hNuVM11qyAtD
	Dvzf4pSbgZucnbVEbhM1Gld6aUC2wahQmqE8iQfNZcZtgEEEb9rWrBxac8ZqObHWTvMbdTZngz5
	q6dt4vuscUAzDSdrDtTOh/V3Ed2Fw/H399H+ezFStX1FhEmzUfU0wnRFJFhQQEt70fXK2RQ3zHy
	oqbINQX46ojvyqG8Xkjypy5cGxkO7iB9PNbs8p43yQSsYuUlKpXesaDrzfeoXfjVd132MH039PY
	fp8qSFO9EEVdhG1I9u0YqXLRz9DKkBGcimU=
X-Google-Smtp-Source: AGHT+IG+FhwAy1JK5rfDJ9EuiJEFKorMvJUyqFqgU1WgQXv/IXKf5RiyuXR/fbKToKNgkcmu8ldDYg==
X-Received: by 2002:a05:6a00:be0:b0:72f:59d8:43ed with SMTP id d2e1a72fcca58-72f59d84743mr10338020b3a.14.1737592473779;
        Wed, 22 Jan 2025 16:34:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba535casm11789678b3a.151.2025.01.22.16.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:34:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1talAz-00000009IFd-3WFC;
	Thu, 23 Jan 2025 11:34:29 +1100
Date: Thu, 23 Jan 2025 11:34:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
Message-ID: <Z5GOlVQpN47LLmo1@dread.disaster.area>
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area>
 <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>

On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> For the HSM prototype, we track changes to a filesystem during
> a given time period by handling pre-modify vfs events and recording
> the file handles of changed objects.
> 
> sb_write_barrier(sb) provides an (internal so far) vfs API to wait
> for in-flight syscalls that can be still modifying user visible in-core
> data/metadata, without blocking new syscalls.

Yes, I get this part. What I don't understand is how it is in any
way useful....

> The method described in the HSM prototype [3] uses this API
> to persist the state that all the changes until time T were "observed".
> 
> > This proposed write barrier does not seem capable of providing any
> > sort of physical data or metadata/data write ordering guarantees, so
> > I'm a bit lost in how it can be used to provide reliable "crash
> > consistent change tracking" when there is no relationship between
> > the data/metadata in memory and data/metadata on disk...
> 
> That's a good question. A bit hard to explain but I will try.
> 
> The short answer is that the vfs write barrier does *not* by itself
> provide the guarantee for "crash consistent change tracking".
> 
> In the prototype, the "crash consistent change tracking" guarantee
> is provided by the fact that the change records are recorded as
> as metadata in the same filesystem, prior to the modification and
> those metadata records are strictly ordered by the filesystem before
> the actual change.

This doesn't make any sense to me - you seem to be making
assumptions that I know an awful lot about how your HSM prototype
works.

What's in a change record, when does it get written, what is it's
persistence semantics, what filesystem metadata is it being written
to? how does this relate to the actual dirty data that is
resident in the page cache that hasn't been written to stable
storage yet? Is there a another change record to say the data the
first change record tracks has been written to persistent storage?

> The vfs write barrier allows to partition the change tracking records
> into overlapping time periods in a way that allows the *consumer* of
> the changes to consume the changes in a "crash consistent manner",
> because:

> 1. All the in-core changes recorded before the barrier are fully
>     observable after the barrier
> 2. All the in-core changes that started after the barrier, will be recorded
>     for the future change query
> 
> I would love to discuss the merits and pitfalls of this method, but the
> main thing I wanted to get feedback on is whether anyone finds the
> described vfs API useful for anything other that the change tracking
> system that I described.

This seems like a very specialised niche use case right now, but I
still have no clear idea how the application using this proposed
write barrier actually works to acheive the stated functionality
this feature provides it with...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

