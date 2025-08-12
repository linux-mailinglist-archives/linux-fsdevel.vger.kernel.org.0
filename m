Return-Path: <linux-fsdevel+bounces-57483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B885B2209B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796A33BFCCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89C2E267A;
	Tue, 12 Aug 2025 08:21:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF52E2664;
	Tue, 12 Aug 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986899; cv=none; b=Xj0Dvt0rLNh0byF9sm5vMVindl9DFQaLrDLUaW5igqExvtWhcLQKA3pKXt9wq6K3TbaZ4Z4iFnBtqBmDK+DWM8aV7ZbQLg2dezIrblKPCDLtwOKS4vZKSmH1ieIFUbfZ8HQXodwHa28K76iL2P4g4/nP7Cxo5LdxdtddvYJ9HJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986899; c=relaxed/simple;
	bh=v6ku6uoTclEFGpy3t3fL4N4Pn9sCBbvqfzct8K5Ilh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KysqMAw99mlZ4wMal7Rw6SnCDOBRzdyGz44Di/OW+7RjaiVwYvhovMVeTC+VGBr4/V8xrBbICl1LOCzQnzzJ+tytNzKGR2cspzXJIHn3b5nNv5DH5TprkuAGh7pLH06EW72X2bj106ciKnHlxwCKceB/+uZvbmbxAXVY7I7yu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47AE268AA6; Tue, 12 Aug 2025 10:21:32 +0200 (CEST)
Date: Tue, 12 Aug 2025 10:21:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC PATCH 1/5] fs: add a new user_write_streams() callback
Message-ID: <20250812082132.GA22212@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145333epcas5p49b6374fdedaafc54eb265d38978c1b8c@epcas5p4.samsung.com> <20250729145135.12463-2-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729145135.12463-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 29, 2025 at 08:21:31PM +0530, Kanchan Joshi wrote:
> so that filesystem can control number of write streams for user space.

This feels the wrong way around.  I'd rather implement the actual interface
to get/set the write streams in the file system (maybe using common
helpers) than encode the nunber in a file operation.


