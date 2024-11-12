Return-Path: <linux-fsdevel+bounces-34458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56BB9C5A49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F80B240FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415401FC7D1;
	Tue, 12 Nov 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drzD+FsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3211FBF5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419869; cv=none; b=klZOH/yUCQtEh0GsymcP/YgcQkYypv+g+nfl/ZaB1bmgUPsIbMWAUj78em66JQHHbk1G6arqXLhtsB+wSOQ2X5i8+N9RkPj+J6cHF8v4PKKV+0qVBVpie+kyz8FxmifebQvRnsa0n2ynZMIHfLfN9vhkMJ+2/j0jIK1pQ/iJ1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419869; c=relaxed/simple;
	bh=FjL7ZZXZBfFudzDPcyKd+YwRpqlxdJIHV35irM1YQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz6pkhFQIKbYlDHTR8scYdUVGGmE55PSu4xsUMH+vaCzkfylgvAzfA/IMW7IYs+d9VeY0G7xiwpEfo7j/oSE5HkNayX72gvpaJfidrXc85mmSMMCcbvmcDb+LrDpc7vW3tH1KPmSVm3ozqH6HvDHvwPwKj8OTGBjqd06hLiLjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drzD+FsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogu7EjeW2AopvdKhG1NBnIXBh6O2/JqbIWgc1JYPvCE=;
	b=drzD+FsETbjDa/IDUDZRxRSGnDzxlvExwQRc3FgWtVH/egk33whwViWKtwTBgbrwM4Yb6o
	mXIIbimp7kQ93rPqzv2ulka1+xnAAnoBnjl8qwKuMa+LCWbbHHTkzohLeQCN5LqXcRPiGm
	l3i+rfAp6n/s268cOvzZJNiXGCAiIrI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-Tlm57g36NR-BQld0vfwUqQ-1; Tue,
 12 Nov 2024 08:57:46 -0500
X-MC-Unique: Tlm57g36NR-BQld0vfwUqQ-1
X-Mimecast-MFC-AGG-ID: Tlm57g36NR-BQld0vfwUqQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC23E1955F42;
	Tue, 12 Nov 2024 13:57:44 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 554763003B74;
	Tue, 12 Nov 2024 13:57:44 +0000 (UTC)
Date: Tue, 12 Nov 2024 08:59:16 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iomap: reset per-iter state on non-error iter
 advances
Message-ID: <ZzNfNBdB9i46jyqX@bfoster>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-2-bfoster@redhat.com>
 <ZzGb9is7JIpNNVkZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzGb9is7JIpNNVkZ@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Nov 10, 2024 at 09:53:58PM -0800, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> (btw, can you keep Ccing iomap patches to linux-xfs per the entry
> in MAINTAINERS?)
> 

Yeah.. sorry, I didn't realize that was a thing.

Brian


