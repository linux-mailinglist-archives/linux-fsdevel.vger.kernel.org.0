Return-Path: <linux-fsdevel+bounces-1198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA667D7203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D943C281C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CBB2AB48;
	Wed, 25 Oct 2023 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXPBnBUF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3FuMUGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92716435
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 17:04:51 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D4111;
	Wed, 25 Oct 2023 10:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8510D1FF6D;
	Wed, 25 Oct 2023 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698253488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/b0U4rxVns8SLoSRhIYGbax8k8wks9GCNBBynewSLQ=;
	b=yXPBnBUFmsQuNBdGZBQmxuwUdqotAq945kUYAxi2XjA2AWCODe38XAqHWrcz2gm2KrQeJF
	UGziqyvAKZjvjedw6DR2H6hrO0HTsi64bR6HlWr0VjdrHsNhFR/Zw0hkBjqOAgNfjCfgsb
	ZJEg+KUQJa5CtKduQwzCSSK/3F1KynE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698253488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/b0U4rxVns8SLoSRhIYGbax8k8wks9GCNBBynewSLQ=;
	b=F3FuMUGlXvGfdecCKOIE6ghRuP4kKFRrI0tIYfqyxX8G+H00Z2DO8410rIPtEnhlzhlais
	3MlN3K+yerH3EYAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75D38138E9;
	Wed, 25 Oct 2023 17:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hqy/HLBKOWVTXgAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 17:04:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80CC1A0679; Wed, 25 Oct 2023 19:04:45 +0200 (CEST)
Date: Wed, 25 Oct 2023 19:04:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231025170445.qks7etxtwivyqz22@quack3>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTk1ffCMDe9GrJjC@infradead.org>

On Wed 25-10-23 08:34:21, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
> > Jan,
> > 
> > This patch set implements your suggestion [1] for handling fanotify
> > events for filesystems with non-uniform f_fsid.
> 
> File systems nust never report non-uniform fsids (or st_dev) for that
> matter.  btrfs is simply broken here and needs to be fixed.

Well, this is the discussion how btrfs should be presenting its subvolumes
to VFS / userspace, isn't it? I never dived into that too closely but as
far as I remember it was discussed to death without finding an acceptable
(to all parties) solution? I guess having a different fsid per subvolume
makes sense (and we can't change that given it is like that forever even if
we wanted). Having different subvolumes share one superblock is more
disputable but there were reasons for that as well. So I'm not sure how you
imagine to resolve this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

