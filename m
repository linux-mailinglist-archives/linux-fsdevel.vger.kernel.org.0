Return-Path: <linux-fsdevel+bounces-56756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A8B1B54E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1D618A518D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D626272E6B;
	Tue,  5 Aug 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TFaK1Air";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/oIFz6ep";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TFaK1Air";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/oIFz6ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538892E36E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401967; cv=none; b=hkg3jHpts9yHK99AHpNm6S5bck81+uNWUGyo1HdSSvBpcHYnh3cMUEAyHFPVDhiPid88b6Z1ZUNMGJDatxxFITKKuBjA5wGriTkMAE4ta9CU2N/aqLReoXQwi+4SJe/ZgYZCkHqdbV3HpmJXt7zhvgP8f5NTMoRFw56yUZdm7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401967; c=relaxed/simple;
	bh=gLG8KOKo2A7O0qzRZHDR7qZfwlpuyV1xda4J7K8lzM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvCfK/1RbG/HVMy3RNl5fVntZDCl17NvvdUu4X+pabKVRzzH6bBmJdCyT5WjS0YCyzh4FuPiFyoPAurQq6GHDWi5nCNeL4mXWTiNgHb8ObfefJLSMChBf/sFm6BpdxNl27gls2acjJTes2qu3JEBtJRvAmBusFK/grFF6DHbZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TFaK1Air; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/oIFz6ep; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TFaK1Air; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/oIFz6ep; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 925051F38C;
	Tue,  5 Aug 2025 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754401964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAh53zY1lvWrZrojt1yd+p+oDdF0IdKFV8KZZpy14Y=;
	b=TFaK1AirMexI4X+ZixOzrgEw3F9VDJGrF4Y9gA6fnYAVLnSEHo3TFPtyZ0oiReyNqjuEyD
	eyJYoB4sZUR6vnlP5PN4MBl9vv6tMSrAMDMlbigQuArtx4JQHngIJgFa/eHVuzLQKYl2G1
	Wf4W+zi54se9wsrXMVLq/HjIVxVD/TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754401964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAh53zY1lvWrZrojt1yd+p+oDdF0IdKFV8KZZpy14Y=;
	b=/oIFz6ep0M4knK8jczmZOc0+Qyd5T/bnhVZ6KqhKwOb8us1kG9HHzyRE5cDBTcqKBBvPnL
	Y3JOJPIk40Fge8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754401964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAh53zY1lvWrZrojt1yd+p+oDdF0IdKFV8KZZpy14Y=;
	b=TFaK1AirMexI4X+ZixOzrgEw3F9VDJGrF4Y9gA6fnYAVLnSEHo3TFPtyZ0oiReyNqjuEyD
	eyJYoB4sZUR6vnlP5PN4MBl9vv6tMSrAMDMlbigQuArtx4JQHngIJgFa/eHVuzLQKYl2G1
	Wf4W+zi54se9wsrXMVLq/HjIVxVD/TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754401964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiAh53zY1lvWrZrojt1yd+p+oDdF0IdKFV8KZZpy14Y=;
	b=/oIFz6ep0M4knK8jczmZOc0+Qyd5T/bnhVZ6KqhKwOb8us1kG9HHzyRE5cDBTcqKBBvPnL
	Y3JOJPIk40Fge8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776A813A55;
	Tue,  5 Aug 2025 13:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DfPoHKwMkmhcJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Aug 2025 13:52:44 +0000
Message-ID: <1eb5d0ef-efea-4ed5-85b1-bf4f685ddb90@suse.cz>
Date: Tue, 5 Aug 2025 15:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] fs/proc/task_mmu: factor out proc_maps_private
 fields used by PROCMAP_QUERY
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250804231552.1217132-1-surenb@google.com>
 <20250804231552.1217132-3-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250804231552.1217132-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,google.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/5/25 1:15 AM, Suren Baghdasaryan wrote:
> Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
> ioctl are moved into a separate structure. In the next patch this allows
> ioctl to reuse some of the functions used for reading /proc/pid/maps
> without using file->private_data. This prevents concurrent modification
> of file->private_data members by ioctl and /proc/pid/maps readers.
> 
> The change is pure code refactoring and has no functional changes.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


