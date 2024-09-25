Return-Path: <linux-fsdevel+bounces-30046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA269855A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DF528383B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F215A848;
	Wed, 25 Sep 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTDUIOc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403B15B115;
	Wed, 25 Sep 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253471; cv=none; b=X8i/QVLdoUjWYRzvcB/4PiZbX3RqeSwKJrEvqENMMLHBYwmz5BMrEHkYUag9lzBmc4O0BuBbmWQmYa3LPDJO7z0anovb0aZMW6imZ2o9Fe+nOjtecJA2BmX9yp255MX+h24Jv3A9pc9+7wpyzrMkw6KoWYDwR9/PQEbdX/MKlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253471; c=relaxed/simple;
	bh=GqbkQOdcm8QXzxKCBZsg4XWv2szVsRWiax+UoIXnOsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkvllP+k+XjuBRMMswlTVkjfiAhB1Y5x92EJ2GcBsueh9M/+38uzJU+unaccTOiVru3DliVwULJL9o/ViBh+0J7e17rukvjTglwnsVbKrs+ZUJnPIr8uWYzetj7ygk0bQ5nYVKJCCPpyP6veMbpDgcWP28hUXcBIEWDvjNkE10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTDUIOc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FFBC4CECD;
	Wed, 25 Sep 2024 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727253470;
	bh=GqbkQOdcm8QXzxKCBZsg4XWv2szVsRWiax+UoIXnOsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTDUIOc4FyWn+aNHyz5x29mh5Sz8rKsgTPbgAyZI46lSMY24AROixmk7zIlk70eYT
	 frGZO0/uvej1D7+ltFaFpWyT010IGXkw8kcLCEYlnrnrMO3fJ33DJHeZQ+kqi20vOE
	 DVWFv0gOWk2Vgj2lcJJo0l6VTxBTocPkWpqzgppMFx2tPGcxgg7yEUZui7QJfQ8C2p
	 ZwVluqnHh4dXiej8+fuOahG5aB6ZJtDMagh4bXI/WbyX8+1ryW5XbAv3ONdxztudOe
	 IJfYyvBCB+2ngKRUx0HtZzeM/KFRHedZJEtBdWgGSX/p6Iml43caFL1Qw7g+5aYc4k
	 uhHsFTJ09S7cQ==
Date: Wed, 25 Sep 2024 10:37:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, stable@vger.kernel.org, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing
 overflow case
Message-ID: <20240925-anflug-flossen-071b110c324b@brauner>
References: <20240920122851.215641-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920122851.215641-1-sunjunchao2870@gmail.com>

Unrelated to the semantics but why do you use 2/3 numbering for a single
patch? This is really confusing.

