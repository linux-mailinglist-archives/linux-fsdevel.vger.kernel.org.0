Return-Path: <linux-fsdevel+bounces-49551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64AABE88D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 02:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679367B6D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3012D758;
	Wed, 21 May 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FlL6H96v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5C17E;
	Wed, 21 May 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747787551; cv=none; b=s2Me1q3jiPl+tir0NvoXWmLxAhVXMryXvdME79i7Kj/SrhqhDSIfx2GeSNOH5uE21spvlHUVK1tOLkhzNAiYJpfusb7dAaaChr5E+g2+Ilfj7pyrraQV/HulLQrcIFJAKX3CJ33a+WIQXGUHhrevqgnhO4F1ZnLzFxyKK1yiLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747787551; c=relaxed/simple;
	bh=fGWSogIpp3TKjPGsD6G2U2naE/ASQSOoM2byNJmS9SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEVh1lpuRZ7OtduetdGQAWFKYYByT42+jSCxZB3ZxaYgfE3iSeBVj0qxqm6ZoAiz1RmlpFkBlOXmc2XE6TjwLguzptejeOfiu7tnfEWQdKDS+WixBVCBDg9FhR5jya0Z/7OoBauoWZOE689+zJyOMI06rgpC+0+ni//2sFyroyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FlL6H96v; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747787551; x=1779323551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xEI+3cw+m02lVsLKZ/U/Cq3BXMtRGmsEPyJIbqzNDXo=;
  b=FlL6H96vTSwPcHCOlHJTb2ER9EtMAhLtUv1aZG16YzhtZQWj+vwjoWcQ
   vmVyJZ98s6F63xzqv1SjH6C9mJ5+azViUike2eQvOX2K+Q0r2ehoehcWv
   FyATtm00h0gSneREIIqZ/XUQCHZXpbaKIH7/soHZuDwksIN49T0TxAzYY
   UcXlUl/Vkpc3bayD6kEM/rWlQa1gjeq0FaJITC2XO7N1G80wePmgalqfo
   vUy6CC52QpWf6QaXldfDfckoOAnb/rdSKlwdcArrolKZFyW6hueH6AMli
   RRznZcNJFsiYrvphha5ntbsManVYEqtohxlMYhr777DjsqQJuWqMQxI3I
   A==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="500790503"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 00:32:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:46847]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.122:2525] with esmtp (Farcaster)
 id 8fe77178-6a7e-4a39-aa1b-6b78976c9145; Wed, 21 May 2025 00:32:25 +0000 (UTC)
X-Farcaster-Flow-ID: 8fe77178-6a7e-4a39-aa1b-6b78976c9145
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:32:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 00:32:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stephen.smalley.work@gmail.com>
CC: <anna@kernel.org>, <brauner@kernel.org>, <casey@schaufler-ca.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jack@suse.cz>, <jmorris@namei.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>, <omosnace@redhat.com>, <pabeni@redhat.com>,
	<paul@paul-moore.com>, <selinux@vger.kernel.org>, <serge@hallyn.com>,
	<trondmy@kernel.org>, <viro@zeniv.linux.org.uk>, <willemb@google.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity() interface
Date: Tue, 20 May 2025 17:31:49 -0700
Message-ID: <20250521003211.8847-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Apr 2025 15:50:19 -0400
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
> 
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[...]
> diff --git a/net/socket.c b/net/socket.c
> index 9a0e720f0859..bbcaa3371fcd 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -560,17 +560,14 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>  				size_t size)
>  {
>  	ssize_t len;
> -	ssize_t used = 0;
> +	ssize_t used, remaining;
> +	int err;

Paul: Could you sort this in the reverse xmas tree order before merging ?
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

otherwise the socket part looks good to me:

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


>  
> -	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
> -	if (len < 0)
> -		return len;
> -	used += len;
> -	if (buffer) {
> -		if (size < used)
> -			return -ERANGE;
> -		buffer += len;
> -	}
> +	err = security_inode_listsecurity(d_inode(dentry), &buffer,
> +					  &remaining);
> +	if (err)
> +		return err;
> +	used = size - remaining;
>  
>  	len = (XATTR_NAME_SOCKPROTONAME_LEN + 1);
>  	used += len;

