Return-Path: <linux-fsdevel+bounces-48256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6589AAC78A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D5520343
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47992281538;
	Tue,  6 May 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKVwgoiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D2280313
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540753; cv=none; b=AgiJaQbS82JRBdUh1thz1rhPSiRZ3ZYEEMGSCQOB3GXasUe9/ZL5lB4Bhl148THLQk3CFj2VRLSkxgXds8r7RWMv8vWNc3RnKEVe5r6xG4FyCGw9Nzzphz67YJqbLJAVAQBAAcsCVielP/EeyOczmwNxKlSk+rkFIORqxOXiXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540753; c=relaxed/simple;
	bh=XD1c/NrpQIDeBwvKOkdv61b/t9i8MDJHuuCpgWDj2wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGDestgvXy5n5Zbja7kOj4d/ZULaRSaWZ3RCZvcXFrkwJC9YfhU1VO6IK0Oyn9VZKof1x+Cszbx6WKBqaDwO/jnKDp4y/E8Fs5MVlwQBQtN/s2rxtmaXxE122aFBOgezIdy9S0QghZti/CNetbHshTMXt5wJqD6pU1Hi18fI0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKVwgoiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746540750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i31uYxi0FuYT/68jil7UkObCV64R/u1atRN70Sz66rU=;
	b=CKVwgoiOK/UJsAN1M4EYvptvr5i7n0We0irBdT8DBnVhoUwz74RDksSAnseyoDXnQ1r6kx
	hBIjmlTEBO87mAa3xEfsaOwc4eVfegUlU536Eb8hz40eUvU+jHyeKVPH51hSCn7TNpxBhf
	p7Kp1Ph60o6jlADTRJN/wLNoaerSqR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-ROnsn2egM2aZIGCdWqXJuA-1; Tue,
 06 May 2025 10:12:27 -0400
X-MC-Unique: ROnsn2egM2aZIGCdWqXJuA-1
X-Mimecast-MFC-AGG-ID: ROnsn2egM2aZIGCdWqXJuA_1746540745
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B2C81955E87;
	Tue,  6 May 2025 14:12:25 +0000 (UTC)
Received: from fedora (unknown [10.44.33.234])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C17751956094;
	Tue,  6 May 2025 14:12:23 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 May 2025 16:12:24 +0200 (CEST)
Date: Tue, 6 May 2025 16:12:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfs: detect refcount bugs
Message-ID: <aBoYxYjmyvSKvFff@redhat.com>
References: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

I am traveling until May 15, can't read the code, but FWIW this change
looks good to me.

Oleg.

On 05/06, Christian Brauner wrote:
>
> Now that we have pidfs_{get,register}_pid() that needs to be paired with
> pidfs_put_pid() it's possible that someone pairs them with put_pid().
> Thus freeing struct pid while it's still used by pidfs. Notice when that
> happens. I'll also add a scheme to detect invalid uses of
> pidfs_get_pid() and pidfs_put_pid() later.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/pid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 26f1e136f017..8317bcbc7cf7 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -100,6 +100,7 @@ void put_pid(struct pid *pid)
>  
>  	ns = pid->numbers[pid->level].ns;
>  	if (refcount_dec_and_test(&pid->count)) {
> +		WARN_ON_ONCE(pid->stashed);
>  		kmem_cache_free(ns->pid_cachep, pid);
>  		put_pid_ns(ns);
>  	}
> -- 
> 2.47.2
> 


