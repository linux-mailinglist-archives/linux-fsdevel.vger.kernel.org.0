Return-Path: <linux-fsdevel+bounces-75264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNAmIjBac2nruwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:23:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2C74F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFCF302DF5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30090310647;
	Fri, 23 Jan 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7yaTJ3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0E2D3EF2
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167355; cv=none; b=Jve/jwlJGKEoP4BGWsjxYXUVgvXxOfsxRIp321/Drw8Yu199JaLtirkuYzApCal+BnVJq7hOrKpH+ebK29aAAIyzWDxMdEG0My5LSn1CFbx0Bc/+nUh54AQOn7r75ymY8ONuR8Ai0BF8es+Gcgq7bnxu7hhRkEVvodYI0uCn9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167355; c=relaxed/simple;
	bh=bvglYHGxnU/CmnodVC/WwAyr61cmVhXWA4sj+Tb68rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYt3eWnDWc0xGct3YXV1ShFGoAWr2OjuZmzTpasO+cP8tLmetasAB0X/SB7gDP9cISTVs6yu7EmZF7bduExAlQM0xtzeBtUZmXh6wT5pCK8NM6kBvWs3pCovXRL1EN5W22uNxXM+YpoJoNTYwxExM1Gq1spfL0WMIIDiduhyMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7yaTJ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402EAC4CEF1;
	Fri, 23 Jan 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769167355;
	bh=bvglYHGxnU/CmnodVC/WwAyr61cmVhXWA4sj+Tb68rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7yaTJ3QZnGxcFEny4j5ztiJKp2dKlpwtrdxEsivxL9s2TgIZYP3kNO3LCgnxW+Rl
	 wHv07gdfWd2K4ly+PCydebNUzOvNvpaYVKrX8Q1Ek4VtFb1zYKFQYi8uZpG20zf0ia
	 ll353o4yKH5JCP7tzxEE+x7Ic8xNPoQGvP3vD65SRCNJauRUEnylJHPQ7kAqSBL9nG
	 1DFpbw+sspaDhNswc9fdvO2RC19Ax9e1jTbe6anTZbtWgf52MHhV38IOEdk1UnCi/1
	 T9HCfcw4Fx09SP0jSbB/HGCtH4YKBJnWzofY19cktzoWJg4Vr9+BrxGKdnBh4ga4F6
	 Mm5tDzB8RTF+Q==
Date: Fri, 23 Jan 2026 12:22:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Use connector hash for destroying inode
 marks
Message-ID: <20260123-mengenlehre-wildhasen-46e47a6e7558@brauner>
References: <20260120131830.21836-1-jack@suse.cz>
 <20260120132313.30198-5-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120132313.30198-5-jack@suse.cz>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75264-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1C2C74F5A
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 02:23:10PM +0100, Jan Kara wrote:
> Instead of iterating all inodes belonging to a superblock to find inode
> marks and remove them on umount, iterate all inode connectors for the
> superblock. This may be substantially faster since there are generally
> much less inodes with fsnotify marks than all inodes. It also removes
> one use of sb->s_inodes list which we strive to ultimately remove.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c | 71 +++++++++++++-------------------------------
>  1 file changed, 20 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 706484fb3bf3..a0cf0a6ffe1d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -34,62 +34,31 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
>  }
>  
>  /**
> - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
> - * @sb: superblock being unmounted.
> + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
> + * @sbinfo: fsnotify info for superblock being unmounted.
>   *
> - * Called during unmount with no locks held, so needs to be safe against
> - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
> + * Walk all inode connectors for the superblock and free all associated marks.
>   */
> -static void fsnotify_unmount_inodes(struct super_block *sb)
> +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
>  {
> -	struct inode *inode, *iput_inode = NULL;
> -
> -	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -		/*
> -		 * We cannot __iget() an inode in state I_FREEING,
> -		 * I_WILL_FREE, or I_NEW which is fine because by that point
> -		 * the inode cannot have any associated watches.
> -		 */
> -		spin_lock(&inode->i_lock);
> -		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -
> -		/*
> -		 * If i_count is zero, the inode cannot have any watches and
> -		 * doing an __iget/iput with SB_ACTIVE clear would actually
> -		 * evict all inodes with zero i_count from icache which is
> -		 * unnecessarily violent and may in fact be illegal to do.
> -		 * However, we should have been called /after/ evict_inodes
> -		 * removed all zero refcount inodes, in any case.  Test to
> -		 * be sure.
> -		 */
> -		if (!icount_read(inode)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
> -
> -		__iget(inode);
> -		spin_unlock(&inode->i_lock);
> -		spin_unlock(&sb->s_inode_list_lock);
> -
> -		iput(iput_inode);
> -
> -		/* for each watch, send FS_UNMOUNT and then remove it */
> +	struct fsnotify_mark_connector *conn;
> +	struct inode *inode;
> +
> +	spin_lock(&sbinfo->list_lock);

I think you could even make this lockless by using an rcu list.
But probably not needed. I assume that sbinfo->list_lock will not be
heavily contended when the filesystem is shut down.

