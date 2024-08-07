Return-Path: <linux-fsdevel+bounces-25327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319794AC96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834481C208CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DD12BF02;
	Wed,  7 Aug 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3TUaQoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63327D3E4;
	Wed,  7 Aug 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043853; cv=none; b=lIHNxX7J0ajs9zy140V39SskDxsaMNMQcl/VS9IyM1AgVI/K86dmc4CA8gCQdpYR95YzFXZ3W3XYSR0LOWQ9ON/rDob56fuJ6u30vghgIMN0W2zKmXN2xHhUcmGWXBtBHL5jmaPfE0ZdxJGb7WlTGVzMbuPd05MEA7vLK58P8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043853; c=relaxed/simple;
	bh=/z8rWo6lRF06Eu8KwlaXy7cG2JX+ag7Ljm0iD7hk2Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8EPqwLYhYQZNq40l4a5Ii23IQLiLW8aamtBLT4ip2iY0UgAZMNLeb2it6t/jeHJGJZaMCQy09wLPdqIksekDoKe9+PVxxuOY/uF+rWWD3V6Kq+2OadpSQ27wGrhIBuJ2tyaRt4SKWCA34nxirD9R93f4XkN1VWJqFwJG4ax31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3TUaQoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352F0C32781;
	Wed,  7 Aug 2024 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043853;
	bh=/z8rWo6lRF06Eu8KwlaXy7cG2JX+ag7Ljm0iD7hk2Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3TUaQoM+BqXR8OMaKRzxC1os28ge4J4DQaJmqLJU9/0SLQ6QKgOZGNWzB33gd3ri
	 4NzaCxAHpgIsZBivFU5r/iJP4X8D7RODOBLyoUXkFpyPa0xrLTwFXBRLQoQXK4u4rA
	 PcquQ7GQiTv76IGmo66GcNNSZhi9lPCwaIQWl3OiiJxSlluVR3PEgworhHQrKcRJhP
	 HycPMgryMRL5e35gA8UrlMoT9EH53+u48FJ508djBMRM/2dmkRiS9QOoo9cC9nKzLV
	 7Sn5yMpIy49IwT0NVvdmBNzu+LnoYMz80ABivfgW8UtcbIw64Jy6PufzTZrL3CBnCi
	 io2jvWhc49kng==
Date: Wed, 7 Aug 2024 08:17:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 14/14] xfs: Enable file data forcealign feature
Message-ID: <20240807151732.GH6051@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-15-john.g.garry@oracle.com>
 <20240806194321.GO623936@frogsfrogsfrogs>
 <19fb82cd-77e6-43af-a0a2-c08700b04066@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fb82cd-77e6-43af-a0a2-c08700b04066@oracle.com>

On Wed, Aug 07, 2024 at 02:50:18PM +0100, John Garry wrote:
> On 06/08/2024 20:43, Darrick J. Wong wrote:
> > On Thu, Aug 01, 2024 at 04:30:57PM +0000, John Garry wrote:
> > > From: "Darrick J. Wong"<djwong@kernel.org>
> > > 
> > > Enable this feature.
> > > 
> > > Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > You really ought to add your own Reviewed-by tag here...
> 
> ok, if you prefer. Normally I think it's implied by the context and
> signed-off tag.

SoB means only that either you've written the patch yourself and have
the right to submit it, or that you have the right to pass on a patch
written by someone else who certified the same thing.

An actual code review should be signalled explicitly, not implied by
context.

--D

> Thanks,
> John
> 

