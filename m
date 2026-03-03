Return-Path: <linux-fsdevel+bounces-79212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMzKEBHXpmnHWgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:41:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1E1EF9E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05C23137138
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590DA34403E;
	Tue,  3 Mar 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8dFu4S7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc5saU2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093132F757
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541166; cv=pass; b=WI5CPYfBk16QnRVIvHNnsSpv42TbVsmnFBtnB3jPy9f0QkHR7eAKHB5rfOsyhurl8qTTu4m4PIJLlhNxvyya7ShZw0rYkvg58gipP/AvmTVQVqu9NxLfOFil2hzejpT0Aar/B1mgkWomZLfQPEkV8UwyExByelMYPYtXUVIFnqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541166; c=relaxed/simple;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6GgHUL4CUFIkcGDtME22kcwzO18qzgoTWJJfBQV+9rhrUxdh/TW0FKTx7JBw4r75rXHbBpNfT5vFqR4nXbVswPxAmBbq8tKEjMfFzDLSq4lv+b0lD+ZZ6AE1sf418AN/d9CYCkcbTE4H1PG16kprZhfeedj9Ll6AdBRtP8u28Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8dFu4S7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc5saU2E; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
	b=a8dFu4S7JefFGS+0kKamr7Vu2juHCbECEOM4LvUK4KrsLOmKKIQvnGTMf8pDGksBOPIUVy
	wHvV7cZaxrillKvA+VZG/0cvGpNHc5SWpp7jLJu+WKMb/H2Ai1aCpNumQhHbd7jEGm/ZFs
	GiqZhLRFQGzAkdbuT81Vla6cLZUgYqw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-a9IyJd6VOI-aXXcwxE0s1g-1; Tue, 03 Mar 2026 07:32:43 -0500
X-MC-Unique: a9IyJd6VOI-aXXcwxE0s1g-1
X-Mimecast-MFC-AGG-ID: a9IyJd6VOI-aXXcwxE0s1g_1772541163
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7962f1424d2so91087777b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 04:32:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772541163; cv=none;
        d=google.com; s=arc-20240605;
        b=ZzxKB7i6Jxdl2kMg5UW2VG335a8ezWx8os/WDhmckJlEMDRJroIqTqiZfFO8AEcP1y
         lml/gTRJ7BzkxqsODi1t6WYpVzvu2vYMY5mva7heEaQWWbUA7aw8+K/ImVZsKN4zOhwf
         Tkr7sK0J0Hm3DBg6YN6UvI3NHUmdjshVuVP5NqU34EQUDYWiXd16z6Q6zcPOt9JhjzRs
         mJnanRc8jY64lV0+GoWQEkIG+lZxRT1zQNvKfc1xAiJ4udWWa/ZpEblPtnhNY7mcx++0
         uf5IuHYDng9RaNTB6qgHO2iLjThZBKHToSVWv3YErce49Xse5jtp0jWHmCdSmb+cgxob
         3C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        fh=JGDkmOh59eLqCQtKWeHPKpDXmHGE6iMDJ5dj7SIaskQ=;
        b=A5jmsoq+/ejao3LIv0DlyXUoK94OrEU2f03tFPGJ0fQvLp2sYGYdnQpe1PcwPDCGJQ
         fyy1M2Y5k4e3rWi/weNp0VFtMWYnin1QOnAvr1mrfxUcz8YE7dRi8dRTDQ8W+WT1yWW4
         dQ4EpPx3zJX/Q3T9LjbY1vgfkGMRb0BGQKKRUDq7pB0or7z0H4Nrc1WOk8GHJu2k8PO0
         XdE0JD9guSyvV2dIWF+2SdUhchiuxa4a/p5Rn+5BXAg1p/A1i1Sjn0BfWsFPsh9XaFxZ
         kEj0y7ahMNN/Fu3nM88EHmPVo9KKyQ0KDSXnDfeuq0HMfuEL11DDsIpEwhv8vNyZKxJe
         QkUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772541163; x=1773145963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        b=fc5saU2ElXfHNungKAKLATIvnTe+rHeKlCyQ9Q3llbs/2uiZ6ucv3eBvvngF0arfS8
         92mykTZDjnOFJrCjzc8xEsEIXcCZNqj1jSQM7RZtwZg/MlT1/0StgmKewpxyw+BsPkZz
         gcxnMza2u2ksQfavYm/49ubx0+GcfZ3g1R2CIMFn7B7wBD7401wexYjDkhR27vDddt1H
         qmdShPSaHEnk4NyM6kbTRn2u1R7/rsK1zNwguMYNpS+OMXm6NYk0vQsgeptOOdIibUTh
         NC1HFe+dVihSlk+6Fa8Q282J7bMnDe0RS0bdzA1oafkAJCm3JO5saTiFHtxP/3l5tBq2
         4GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541163; x=1773145963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAsbkvWEurEl7FG/bk0zWpeDiH+kFLfDNlmqSJEZ1OI=;
        b=DJ83WaCYmI9Z0MxsiH48RDeo9CzpcDwFt8oPr0pRRvXHpaud8K8HldvWuyO0tE4QzO
         ROEDsXrTj/gyk128oOzTbr+zsKZtiBa0isEsqqS03qIwsBYTur6IZSxg03Dh6KsIdfh8
         xVCmNx0zLwTrI5rSw4OUfSzZ9UHE+IjA54hrQ9gqBQJ5UDEo4Wxdk86guYJef8uHqIgk
         tLau6oYQQ4KaPj3ENe364uNmKvjCypS2bufB4TI3oeXIhaW5/gnf5PUGRA3BppW+awqD
         ErbeqzxnNk8fIXBGDCFhu+Wm+jqN8RGbkbnoU+f3BC8naaAVMTV/QmHDgBUqowvqSZoe
         8Mzw==
X-Gm-Message-State: AOJu0YzNM/UZVVY0z/LT/VAGVSRKlujgEzvjb6vau/OKaxUFc4k8LUut
	t6lAYUE+iFfKe0Mf/4qj4HKE4j0CH8I3HPfBk+Lvwo+mhGOyEdA1NX7dH+KmfDs9HyXFOem+wk5
	+cMpnYZLeYhqWr6bO84t/88Yq7Vaq6Dy2RUKfcWGdsR8Oyf21l2ELv2qnbLK/k4qLAKNsMcRyD1
	SlkPfEmkVPSpHK2moURFsUTo6bHWa2EzOEI9YZynD/gQ==
X-Gm-Gg: ATEYQzyQyHhjkC6h24noBCjqcTUq0Ujy07zYV1w3ATiAnhBKXXqTVFV9j+bGnf2yi+z
	5arriBmUXgPTsxAET+jniL7sRepqClrJkTP52G7gTC+E4Ds07XFFdZqjRWqetrmJ0YisWQOhO8s
	6hC/aw0V6KxpKeoIHko4RVkKwW5X/DCD4RDJMSYCTr1AE3dobuWx+WUyXKOxAPXEVWqb+4Yyti8
	Fr0iUi+nNX951HplYKfcok6Zl22vL/QcJRBIEb0CXax2nzSfyAIRkSiHutsLJ0Y7Q==
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id 00721157ae682-798855a41d7mr139268317b3.34.1772541163341;
        Tue, 03 Mar 2026 04:32:43 -0800 (PST)
X-Received: by 2002:a05:690c:4986:b0:798:61a4:e2cc with SMTP id
 00721157ae682-798855a41d7mr139267957b3.34.1772541162941; Tue, 03 Mar 2026
 04:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303101717.27224-1-jack@suse.cz> <20260303103406.4355-43-jack@suse.cz>
In-Reply-To: <20260303103406.4355-43-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Mar 2026 13:32:31 +0100
X-Gm-Features: AaiRm51g_TgIhOkGLCDR-668UB9OmDW-WHgYo8dNTw7KZZwkVFcUvPwu-AmQRn4
Message-ID: <CAHc6FU61tUwnFf4pXWun_nLnL2jyUYHLKAN7C1hanbKk0GTZMA@mail.gmail.com>
Subject: Re: [PATCH 11/32] gfs2: Don't zero i_private_data
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-ext4@vger.kernel.org, 
	Ted Tso <tytso@mit.edu>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, 
	David Sterba <dsterba@suse.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-aio@kvack.org, 
	Benjamin LaHaise <bcrl@kvack.org>, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 91E1E1EF9E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79212-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jan,

On Tue, Mar 3, 2026 at 11:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> The zeroing is the only use within gfs2 so it is pointless.

"Remove the explicit zeroing of mapping->i_private_data since this
field is no longer used."

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


