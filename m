Return-Path: <linux-fsdevel+bounces-71679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F1CCCE17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E603033D48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBB3148B8;
	Thu, 18 Dec 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8Mys1Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EE334694
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076580; cv=none; b=ZIFn08AVx9p0oAZ+AOY6fBXqZujQw3shLP4m3FSyz7ibpiyUyp/prx6L6FgdMGxremVyHsv2MSjeEZaTVXNCWOc9ppwFb1LL2RLHVbNWEdMQp7pmu1TVC47CA3XfOVKBQx6MjkS4Wj24PRoCKnGgKbF345/eAiyYrhK5jbLSxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076580; c=relaxed/simple;
	bh=6LYZNsyocsY4qjo9pZBynt4mNppmU1nGKJKUXwScjsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxdVuMY7SGtxKGj9tOd5tcXTOkrxX0QgcJraTRyyqee5LU9HslN9hckPUIGXNgHmIj64dWY2mSruJaPmmZxBerWOK6cmCLaak1GZoNA2Z2VmyxArO138iOg0nc4Z/mw4RC86cFPPyi9/OvF2d/rDxdXQE6BoKKP3dincG/cqaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8Mys1Xj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4fbcbad-459a-412c-918c-0279ec890353@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766076568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU/2T7RNSZEA/sjUllNDju3OHFRl6rRhMVN+oCPb0/E=;
	b=Z8Mys1XjRtn7s1k9Zua3VNFk57wlv1uph3Q75LWCdL02ovmcNp9vzQOlbOLaF5nzE5V/AW
	HElCP7v79lOO9EfqoLdQCAfFtb0XrIU3lP9q0bhsBwTOKqPtgoJyAb6XVhDXd0kdyDKbGo
	O6tFBIj6ieE8xHWKhl6QFOk5v47Az9U=
Date: Fri, 19 Dec 2025 00:49:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from
 smb_hdr
To: David Howells <dhowells@redhat.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>,
 Paulo Alcantara <pc@manguebit.org>, Shyam Prasad N <sprasad@microsoft.com>,
 linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev>
 <712257.1766069339@warthog.procyon.org.uk>
 <753140.1766073714@warthog.procyon.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <753140.1766073714@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Namjae,

It seems David is correct, the `LENGTH` field is described in RFC1002 
section 4.3.1: https://www.rfc-editor.org/rfc/rfc1002#section-4.3.1

The LENGTH field is the number of bytes following the LENGTH
field.  In other words, LENGTH is the combined size of the
TRAILER field(s).

Thanks,
ChenXiaoSong.

On 12/19/25 12:01 AM, David Howells wrote:
> ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev> wrote:
> 
> Actually, should SMB2_MIN_SUPPORTED_HEADER_SIZE include the +4 at all?
> pdu_size is the length stored in the RFC1002 header, which does not include
> itself.
> 
> David
> 


