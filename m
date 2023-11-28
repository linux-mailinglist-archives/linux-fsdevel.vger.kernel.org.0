Return-Path: <linux-fsdevel+bounces-4113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD357FCBA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E1C1C20F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED61876
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227FDA;
	Tue, 28 Nov 2023 15:41:00 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36BD21F8A4;
	Tue, 28 Nov 2023 23:40:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE9213763;
	Tue, 28 Nov 2023 23:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ShoyF4Z6ZmVFXAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 23:40:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <20231128172959.GA27265@redhat.com>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <20231128-arsch-halbieren-b2a95645de53@brauner>,
 <20231128135258.GB22743@redhat.com>,
 <20231128-elastisch-freuden-f9de91041218@brauner>,
 <20231128165945.GD22743@redhat.com>, <20231128172959.GA27265@redhat.com>
Date: Wed, 29 Nov 2023 10:40:51 +1100
Message-id: <170121485154.7109.13588704687316181624@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 36BD21F8A4
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]

On Wed, 29 Nov 2023, Oleg Nesterov wrote:
> Forgot to menstion,
> 
> On 11/28, Oleg Nesterov wrote:
> >
> > but please
> > note irq_thread()->task_work_add(on_exit_work).
> 
> and this means that Neil's and your more patch were wrong ;)

Yes it does - thanks for that!
I guess we need a setting that is focused particularly on fput().
Probably a PF flag is best for that.

Thanks,
NeilBrown


> 
> Oleg.
> 
> 


