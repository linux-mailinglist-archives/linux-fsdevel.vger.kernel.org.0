Return-Path: <linux-fsdevel+bounces-57649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43283B2425C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD63188BF29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949A2D1F4A;
	Wed, 13 Aug 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tl7v/1I/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4652D46A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069188; cv=none; b=Cza2Jp3A8LC/GTjA0V0JHHc2hm7+OgJZjMVxtdtzaTItBVGsTEsx58ZrGjniyvvGpXFwlhxtDOVAfFa7DsabUe6TiY8ibH4E32HaHzJzG/kNH6IDYI+GVC5AnA5Atet0BY9y/HIIL3QHEmixwjywWwzDdwc6HaWCF/+Kb960/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069188; c=relaxed/simple;
	bh=1j9jdz5KuN/FhEqKiYnXZfDwi/9ubhdbH25kLDbXCq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frLkt/tiRT/h9vgqzLD9dxF8D6tjUENs9/WyGBikqk5aqZYB+y4tKFCs477fUdkCQ3jHdz6fV8tbRlza3aFTrq5/Qnas7El7EftP+/1Nk/9jqNfem6Qc7q0A4tXxni2o3Nc1CpjEDYaQut+rd3RBmI6PvQLhM1v+VEY62skQ5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tl7v/1I/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1j9jdz5KuN/FhEqKiYnXZfDwi/9ubhdbH25kLDbXCq4=; b=tl7v/1I/dD+7ErFfjzYj9I72+4
	p94hESpExzTM8rgC0bEjJD+uMzeH1YByn46e58zrKLvcBpa7Z9LslGPMV1KMYZ3edZ69CLTLDkUMB
	hwepZAB96e6dBOGj0t8qKgtv3QgY0wGnR4mYrxf7oryJrrTH4XbZVxjaSXOCuafYyWIFG/AWUGeIH
	lgCIE5o986cim8I3VMXkrDg/XDPecP6G1ze8X02JsVeIC4atk6+OrJEiAsED7ggteKWCNAxvaCDzb
	Zvk4eSlSFgOFgfiCUbwpYdsaRC0E5Au/5a8+DvxiUWdiTck7vw9dV/o4nP2GbFxGzVtpKDBV8J6m8
	/2RvtcTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5fT-00000006wpu-3jZP;
	Wed, 13 Aug 2025 07:13:03 +0000
Date: Wed, 13 Aug 2025 08:13:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <20250813071303.GH222315@ZenIV>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
 <aJw0hU0u9smq8aHq@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJw0hU0u9smq8aHq@ly-workstation>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 13, 2025 at 02:45:25PM +0800, Lai, Yi wrote:
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/repro.c

404: The main branch of syzkaller_logs does not contain the path 250813_093835_attach_recursive_mnt/repro.c.

