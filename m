Return-Path: <linux-fsdevel+bounces-39312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A8A1292B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08C77A14DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379215D5C5;
	Wed, 15 Jan 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiYd82eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1E1304B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959838; cv=none; b=lhYoRT3cO6jbKHhtRq8WTY32OJeJpPWL79MjDtt3CCvUTyNlHmhYOvH1rQlkZA1ffHSkNqWYQdZrZ2Y2fv1fqwKJVQ2qKgMdPf4Mvg+b1f18eWVMR/bKKmt1/Psnrp1Hh1nsdDtWPqVG79XGyfSmws6Pi2SJjB6IoblHaI+IGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959838; c=relaxed/simple;
	bh=7uiX+0BznQeTVwb+auOFCNZ5Qh8o6iZBlWQclp4lkV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=pYc/UUzezuKgGMbgLkH1jsGqyJiEI5g+NckUcfCG/ZAoJhO3ddby7SAnjog3TnWGF3EdLosha5dpE3ioXM36PHBrSWVhGZ2qXG1GSWp+yAUVpE+v+ycx17gRQQN9lGXwGvw84QUbuG/gfRG8zsR7g/98DsJdFHsiQw6ehFHvvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiYd82eZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736959835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iXKmc80peetCGZ5iBWggxR0d+Nz1CYLw+AFLLYTS3e4=;
	b=fiYd82eZcCDWjfVD0xsbhxafRp2pgNP6CNF31unzK1UsIxkgmAAUZ9XYftwH68wFy5hNyd
	PqhaZBR2XOih7nOOPZVQBhn/KYVLd/XnfNVPdwkbwrqJXa66tfc1r8DBu7OORhlf2+ZvTU
	0VOobYnXI5nlZICsDbIZ7pAfnPGsXPE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-2j04WStjNOiYFnBJMUAB4g-1; Wed, 15 Jan 2025 11:50:34 -0500
X-MC-Unique: 2j04WStjNOiYFnBJMUAB4g-1
X-Mimecast-MFC-AGG-ID: 2j04WStjNOiYFnBJMUAB4g
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8498a21afc2so471388039f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 08:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959834; x=1737564634;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXKmc80peetCGZ5iBWggxR0d+Nz1CYLw+AFLLYTS3e4=;
        b=oYqG4eOYVETqeWCxbLeGw45MvFctgHR8JHlkf/oA3ju8DAQCC5hjP3R1B6pGeelsH2
         Mgrml9aCivlIDdIPJgoFBZjZwXHiAzo6EDA1mUtqQ/wgTsvBcMhnZSXzqgyWWmkkwAsh
         KmnTNi9S0VSXSVkYZhhG8ZS1XHJtZ4W1Cs8MD/8A7YFvLukYoqyBVQTc9Llz1L4TdtA2
         bRHN2aPKm7oAWa8cJLyzdicdHLztADLL11FMPq3E2mRJFjRJTQfrRcgyAiFEcPIMNB9R
         pB8ZC2UfgTa8do1vNwbbuSAz0h27+lsT0w+MnKjwtf54chYmfAuWzpeoKeVOdx8lTwz9
         6lXA==
X-Gm-Message-State: AOJu0YznKN8OzDslh5Ti9SX3nnlUPmB+yxopZlLvFv5WKFvLFxzw4bZs
	cf/OdGgdFa34R55Z9FoKvpCedTGoZQhUaA3c10fGDdyuK/9I8D0+cVm8a9bJMw0MkOjNYbAp4Fb
	eLLL0OMXq3i29aJvKPr6INsGhqDlYUSdu2giXIGq9873XJqSxr2rYguIa4O2Ete1O4g417HOrIY
	/tCvgLuRMqpZl0qhYV1sQdNzccKn65U3yjs2vr2HilpTBo8Ngi
X-Gm-Gg: ASbGncsqWQZ2AvdaOObedhFHejGJ5YYhWHqbmLbUOi+TswseLO1EoxckLNiTjBDQYaR
	S+iT4PQviHzLb3jYrC5NJu4GvhmSoyVoIoA8Ez5eQATXEBl3woiD1WnX0U81xTGC4pzJOiPQYi4
	e2iMIOBuWCrrFQAkgYVuay3oSRp+O2EHoBl5NR6u+eDcnhFXftOyAdpmPEa/YC9BNbQe+362kDw
	EA37ZhwyPKEuCS/aB2Zhd78cUBrJldyu1uX4eD5HtgUNql2H5Av2StCSD39fkbyLFgzc5c0bgCW
	So5RGgRzmMWPj48Ini1e
X-Received: by 2002:a05:6602:3585:b0:84a:51e2:9f93 with SMTP id ca18e2360f4ac-84ce00c49f8mr2700873939f.9.1736959833730;
        Wed, 15 Jan 2025 08:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP+wiTh6r0jFYS18N63WpIbN+ol8D+ge1S7CLo8SLKr31IE+95X7NxV2ruOYqdE+VAjTleBA==
X-Received: by 2002:a05:6602:3585:b0:84a:51e2:9f93 with SMTP id ca18e2360f4ac-84ce00c49f8mr2700864439f.9.1736959832919;
        Wed, 15 Jan 2025 08:50:32 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b6151f2sm4130618173.64.2025.01.15.08.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:50:32 -0800 (PST)
Message-ID: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
Date: Wed, 15 Jan 2025 10:50:31 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Sandeen <sandeen@redhat.com>
Subject: mount api: Q on behavior of mount_single vs. get_tree_single
To: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
 Carine Braun-Heneault <cbraunhe@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I was finally getting back to some more mount API conversions,
and was looking at pstore, which I thought would be straightforward.

I noticed that mount options weren't being accepted, and I'm fairly
sure that this is because there's some internal or hidden mount of
pstore, and mount is actually a remount due to it using a single
superblock. (looks like it was some sort of clone mount done under
the covers by various processes, still not sure.)

In any case, that led me to wonder:

Should get_tree_single() be doing an explicit reconfigure like
mount_single does?

mount_single() {
...
        if (!s->s_root) {
                error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
                if (!error)
                        s->s_flags |= SB_ACTIVE;
        } else {
                error = reconfigure_single(s, flags, data);
        }
...

My pstore problem abovec reminded me of the recent issue with tracefs
after the mount api conversion, fixed with:

e4d32142d1de tracing: Fix tracefs mount options

and discussed at:

https://lore.kernel.org/lkml/20241030171928.4168869-2-kaleshsingh@google.com/

which in turn reminded me of:

a6097180d884 devtmpfs regression fix: reconfigure on each mount

so we've seen this difference in behavior with get_tree_single twice already,
and then I ran into it again on pstore.

Should get_tree_single() callers be fixing this up themselves ala devtmpfs
and tracefs, or should get_tree_single() be handling this internally?

Right now in my pstore patch I'm doing:

static int pstore_get_tree(struct fs_context *fc)
{
       if (fc->root)
               return pstore_reconfigure(fc);

       return get_tree_single(fc, pstore_fill_super);
}

but it really feels like this should be handled by core code instead.

Thoughts?

Thanks,
-Eric


