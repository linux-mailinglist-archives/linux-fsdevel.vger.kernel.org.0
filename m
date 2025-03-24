Return-Path: <linux-fsdevel+bounces-44888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941FA6E28B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230EA1886260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DE264F9C;
	Mon, 24 Mar 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTBnQztg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08A26463E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841514; cv=none; b=Fiuh4b8USyRSH7sbJFPKsH8KJo0xEYIgppVWD9Hmm3ACP57xgayq+Ms/vNvOs2p9aUloDdxER9AIfDiQU0rKtS4LF/p8BtlQePEuyfmrEAmNrzpIaSZz2chgNfy02x0Gdy8XS1GxirooDm7HKyVS4Np1znpzLuuzQQE9gvYxEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841514; c=relaxed/simple;
	bh=DFhrkLzWPbRqqwd2LvqqhcGL6D6+0BOVFC/oAWTGg8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1jYV3bz24sGXSeBjCtsSOLDhT8E/kmANiNkEny702qzSF4ADU8UuOpp9+x5e0jWOGxG7w5v6ouUk8IiclhAsDgoZTaxREdqd2lZnGDNKjsuPntYmTeBl9vSSk1CI01jEMcQnh00GAZy3DnIVivV+poq+wOHQIg7Rw4Sm/hh/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTBnQztg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742841512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFhrkLzWPbRqqwd2LvqqhcGL6D6+0BOVFC/oAWTGg8o=;
	b=OTBnQztgD8nHcbo6Vt+iCceaVIO2oc0W8Nd5DlquQp1Cqhu+2aIK5Aa+xCzneSOu4Qdiem
	+XgEJXK/waCCl78Re6m1gjn+SmLeYDbCPK+ufDJTG91Z+JJfVYB6gg9SRdchxVdpIq1wq9
	PZdHT6AtoimQQdMsJiOmLMUm5fo2C50=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-So49VpcsPLSk5FJJVtoabw-1; Mon,
 24 Mar 2025 14:38:27 -0400
X-MC-Unique: So49VpcsPLSk5FJJVtoabw-1
X-Mimecast-MFC-AGG-ID: So49VpcsPLSk5FJJVtoabw_1742841506
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9E218EBE99;
	Mon, 24 Mar 2025 18:38:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 906A6180A801;
	Mon, 24 Mar 2025 18:38:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Mar 2025 19:37:52 +0100 (CET)
Date: Mon, 24 Mar 2025 19:37:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <20250324183746.GB29185@redhat.com>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324182722.GA29185@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/24, Oleg Nesterov wrote:
>
> I won't argue with another solution. But this problem is quite old,

Yes, but...

> unless I am totally confused this logic was wrong from the very
> beginning when fs->in_exec was introduced by 498052bba55ec.

OK, I was wrong. According to git show 498052bba55ec:fs/exec.c
this patch was correct in this respect. Sorry for the noise.

> So to me it would be better to have the trivial fix for stable,
> exactly because it is trivially backportable. Then cleanup/simplify
> this logic on top of it.

Yes...

Oleg.


