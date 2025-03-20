Return-Path: <linux-fsdevel+bounces-44590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC2A6A818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577F94667C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31949222595;
	Thu, 20 Mar 2025 14:13:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E2221563;
	Thu, 20 Mar 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479979; cv=none; b=VqxuIvVwrw3LS65lHLbh3tVzDcMjWQXDPjGuHS+sr2qlVU5dyybWxqykFc3ohCMQ+vhaPSIU3V7Aff8pSW4stOMbick0msTzueT7EXMdjAJtN1omKhGGiUg2zSNJCpAzwZE5ZXk8GymTFaBZ/nvHZlhGvDy5vn8qAVFHWsqgxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479979; c=relaxed/simple;
	bh=iYZLHFS+sUPT1uWziqin4XyUb36fkzNi2aFQ/f4HF5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/MC9nGAyXEL+1O+GQ2N0DI/pi5LSZcEA+ve4qgBDFbOFLm9i+S4arxB34qqBAItDtO8Vd0Spx58uY9JVPuClh1ly/De9bz9n8m9YzT3TmZPCUTNO8lri8lHp24vN0N8aoOD8VusPhKFfhu5DvNT7ckoSe+Xb8xc2seqPAqgkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1522368BFE; Thu, 20 Mar 2025 15:12:54 +0100 (CET)
Date: Thu, 20 Mar 2025 15:12:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250320141253.GD10939@lst.de>
References: <Z9fOoE3LxcLNcddh@infradead.org> <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com> <20250318053906.GD14470@lst.de> <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com> <20250318083203.GA18902@lst.de> <de3f6e25-851a-4ed7-9511-397270785794@oracle.com> <20250319073045.GA25373@lst.de> <ef315f4e-d7e9-48ee-b975-e0a014d10ba2@oracle.com> <20250320052929.GA12560@lst.de> <f8cdd6b1-fcd5-4783-9fdf-bcb6e7c3e992@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cdd6b1-fcd5-4783-9fdf-bcb6e7c3e992@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 09:49:44AM +0000, John Garry wrote:
>>> offset_fsb does not change, and logically cmap.br_startoff == end_fsb
>>> already, right?
>>
>> Afte unlocking and relocking the ilock the extent layout could have
>> changed.
>
> ok, understood. Maybe a comment will help understanding that.

Sure.  As said this was just intended as draft code.  Maybe factoring
out a helper or two would also be useful, although I couldn't think
of a really obvious one.


