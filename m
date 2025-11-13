Return-Path: <linux-fsdevel+bounces-68291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDA5C58C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA05004BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9883D355803;
	Thu, 13 Nov 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YotyaSVI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCA3557E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049198; cv=none; b=ZVxyZEdNbBk67FnH338LW0UJxWmWavusclHIMp3OrSM/VOVdYmyf2BBRXed9TS5xTLLo00c9eO94u59PDAEqALmQlkStlQMI4c6oZ55KJ4O4aGOfPPB6ZHCyw9rv+KgBO/CATq8L8taVyKeJbX4z2Lx/m1x6k4p6JGsv7gp2gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049198; c=relaxed/simple;
	bh=icK/x1mZRyTFn/O1BF3dVwJOlKkZ37+PfErcArasTm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtfuUrtuNXXHWQ5rY5eAZsjGKxhQMqEM5NcYaMlLvHJfjrQzrJc+MTntok5C2iim31b9xWpeexXKgjls77Sy74NxKfNbn48lKPT0SvT9zzi4lsoLpiBj/cLrq4R03TglusAIrVSweAT6GJYi+AEWslO9c3hCfhL4pTBl5NstSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YotyaSVI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ADFqIZg018196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 10:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763049140; bh=YL7gxcG2OTqVIPj/P1PvvSsMZTMZe31BJDoBxi6S53w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YotyaSVITefZW+iWBr+ECnkDi0X++o38vle6nzikwKG2QBFmFhzcNezx1GaYqso/P
	 GSESl+g5sdxYNDxrQ8En0Ih6E3joczt3rgVYFdj8A8B/AE0CXc+7G8R+HdK4z6+/tU
	 Er+KPldtPR9M+iVXXfwflG3O5TID1N7GkJOSXooBvVFZgp/DyNADS6F78xgpAkzpd7
	 4dAVFhTwdhRsUpNMiS+bss9PUkiBuvEQ8nUvhQptQrdm4giz29AHO24IuNMH8JYsgo
	 mWUV5ipP/vhincFiC9ABgiLcQYBOnKEfJAXk5Flsbv4Abt/LgEMlD99Q9jP0zyIeew
	 AdVswnj4y1XUg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2302F2E00D9; Thu, 13 Nov 2025 10:52:18 -0500 (EST)
Date: Thu, 13 Nov 2025 10:52:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, zlang@redhat.com, neal@gompa.dev,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
        bernd@bsbernd.com
Subject: Re: [PATCH v6.1 04/33] common/rc: skip test if swapon doesn't work
Message-ID: <20251113155218.GP2988753@mit.edu>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
 <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
 <20251112182617.GH196366@frogsfrogsfrogs>
 <20251112200540.GD3131573@mit.edu>
 <20251112222920.GO196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112222920.GO196358@frogsfrogsfrogs>

On Wed, Nov 12, 2025 at 02:29:20PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In _require_scratch_swapfile, skip the test if swapon fails for whatever
> reason, just like all the other filesystems.  There are certain ext4
> configurations where swapon isn't supported, such as S_DAX files on
> pmem, and (for now) blocksize > pagesize filesystems.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

