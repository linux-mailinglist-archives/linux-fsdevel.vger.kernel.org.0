Return-Path: <linux-fsdevel+bounces-47902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E4AA6CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D5B9A663D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4222D788;
	Fri,  2 May 2025 08:52:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B922AE7A;
	Fri,  2 May 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175953; cv=none; b=GWjR54RynvVs+2EBPMPDsZ+YyW9cOPIRPjEwwdFlHwGsWjig3/ylxvhhwfT1di2ADa2AdrEKsrjPTsGE0F53jwMnsR5wjZgPckAEQR0TO+yHJD4QgcC3Z1BFDWqrPwTmHlkYM0fh+ZHk3U1YAZJMR/UHZS1AGQSuNU7wBe4kusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175953; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e70hCsKxCT/6qv9KvZ15dH6lsCIGzp09j5JKu96ArG1RDP58QI6nMVJR+Bzju0fTgQN8odtKJii0mm/M1J1QK/luiW1OjQd+axPH2JgIGumTCDm5sa243STLkp0snapsIInlakQqYFqSYvkD/uNbJ660Fr3oso73S5grtrf59Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so1792597f8f.0;
        Fri, 02 May 2025 01:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746175950; x=1746780750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=V92Mfe/ryL1SIDnzyfS71eHWeqWlNUNg7HT8EtpHwKg2R68k0ykt9gxON+SE5aEaxd
         qLUJvEig5JCGFzaoMFy/rEScC9oyTbx06VNgYWLNbabceh/tTEoa2I5a6U0LYLkLP3tN
         hB10QjgRr4RDhCNs00pX2x9BzLw6sOZ6dF5T0LNpr8z4bbfnYmotU630YiOBuJjib2U2
         K2EwLYhpYGy2NwDV9s2Emlch1s2ZSCude1LQn4Zux3rJGkrKF6rMhH43XuoZOqPVxclO
         /jZZ+OkYHjOft4QZEVg7/Q5TxCY0DoM2PArrr9NKxfMPyLYBc8aEEMDfNFXxWg53L8WI
         ApSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt7x8WO93z73ttIKJKxPdGOQcYf55S9/VqW0bQ76nY3zwCN080viEJNyragneSEMfu5/Bp4otD4x/+VMc=@vger.kernel.org, AJvYcCV7R+bPPrduhay/4fQeZSKzs6uUREI57vNmk37HouFMc6wFXs+BAZCKuumhxWK8tx+P+pqYhnXziuE=@vger.kernel.org, AJvYcCVCYlUM5lFJvUzwRR5efRk0pv8zSpveaszdOIcQLuG+dCWMngE5dKzcqMFub41aFgoqXvjojm+5D5fgVds=@vger.kernel.org, AJvYcCWthcTkh+9PCw8XNmbqXBvi1OTlbjUxCmc9V0ntnS8pVFNAdOTmJj4EfAGUGuZfo8GuyfTobJ+wdYaM0yk=@vger.kernel.org, AJvYcCX2yk0Bmlv/sn8ihRMNB1PmbsR8cg2iMiUAQ7m/HNF/z1bq9ld6CgWFMdJ5FbNVQUWH3BW9re8wgceHvngidg==@vger.kernel.org, AJvYcCXYvRq81fE67CRWOYgqXxNaBOHgfOh7TwNoNJW3qhJsZdGYYYtIchkOdGGJbhCFpCorLBI4y83vMsWr@vger.kernel.org
X-Gm-Message-State: AOJu0YyplMvmbXZfEKntnktZzgEaRrWk317G/SzpJcHRyM0Frz877zD2
	wEQTTJXURJAEAYkqTBlpVaHJKpp44kI6+tpFZXjht/2WFXz3WBd2
X-Gm-Gg: ASbGncssTJi36BZcne2KD/oXPKLQXYxGkr6pDvULYxsM6cnTX+rfi262tayFqYIXRQ1
	pjhyabt9hwCbP+f5eTXvfDDfQ94j8xwCxd836+Eh8hKXs/EpHeE+P2DkE1c12r7H+eEPH9iTyOV
	y5AxSACmJBl/gZ5s4EV+KZR4KfzS3PvQgy1oxL5U44oGo698wjKRTnCX+ZWATQ/71H1BG43ROLA
	KRRsjlAWECLcjtRfno5jvBj58GC9PKC9wCnYwdKQeH8mRMd7v1Ck3Rh2T+z3xeSxyz5x3zsC41V
	4eyo46lOdEjeZ9+TNhNksG2+Fjqsh1w0Vj3SymHyGiekfj0xRu9Ekom3pA==
X-Google-Smtp-Source: AGHT+IE9669DK67oKwLOAlAwcYfBBqCESjIKom6hvx2QNNfYlaOOfYtClSN42SPBuE8wsJXFDXbvEQ==
X-Received: by 2002:a05:6000:2209:b0:3a0:82f2:3094 with SMTP id ffacd0b85a97d-3a099af1a8dmr947113f8f.50.1746175949770;
        Fri, 02 May 2025 01:52:29 -0700 (PDT)
Received: from fedora (p54ad9a78.dip0.t-ipconnect.de. [84.173.154.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b172b3sm1535001f8f.90.2025.05.02.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 01:52:29 -0700 (PDT)
Date: Fri, 2 May 2025 10:52:26 +0200
From: Johannes Thumshirn <jth@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/19] block: simplify bio_map_kern
Message-ID: <aBSHykx-sNMJEenF@fedora>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-8-hch@lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

