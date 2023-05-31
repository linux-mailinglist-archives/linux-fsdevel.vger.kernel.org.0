Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059CD717CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjEaKMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEaKMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DC113;
        Wed, 31 May 2023 03:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC2362C22;
        Wed, 31 May 2023 10:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29D4C433D2;
        Wed, 31 May 2023 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685527964;
        bh=h9e+nfF/1mYstq8p3YQMnKuwbpqf8pMUVjhbs8r6/QE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NDo4lgErINET9qRnnxeV6v+NDxXpXA5gZIFGJGCw6UHGHVSJ47sUFCFUgoJrbmshQ
         bPLJUo0k6wnGg0oHbW+MpG7HkGLTPuZ+7xJqEgVj2gHNQSV3u6QeX9az01YGE7x+L1
         /1VVxSMPMbACVJXRZLv4NI5bgYhbN4VkSD8Ywi4P3pVEgoi9HftbBP1g9oN5cez/qR
         SvhVt2XG7YGJijgXoVGZssbgpQwTXhH0VN2e8Pl7zodj/i70NenGET20wwkCdzumFO
         q3PSVBTNUVysGyCEEtDj88I/oqFVPUhKzq0rsgW//A3zqjZhqhkkasLOhS45B2ToWX
         lDg8Ri53wXvfw==
Message-ID: <f932fb72d0cb418d910bfa596ce2d1065d3d8330.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] NFSD: add counter for write delegation recall
 due to conflict with GETATTR
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 31 May 2023 06:12:42 -0400
In-Reply-To: <1685500507-23598-3-git-send-email-dai.ngo@oracle.com>
References: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
         <1685500507-23598-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-30 at 19:35 -0700, Dai Ngo wrote:
> Add counter to keep track of how many times write delegations are
> recalled due to conflict with GETATTR.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 1 +
>  fs/nfsd/stats.c     | 2 ++
>  fs/nfsd/stats.h     | 7 +++++++
>  3 files changed, 10 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 29ed2e72b665..cba27dfa39e8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8402,6 +8402,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp=
, struct inode *inode)
>  			}
>  break_lease:
>  			spin_unlock(&ctx->flc_lock);
> +			nfsd_stats_wdeleg_getattr_inc();
>  			status =3D nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>  			if (status !=3D nfserr_jukebox ||
>  					!nfsd_wait_for_delegreturn(rqstp, inode))
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index 777e24e5da33..63797635e1c3 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -65,6 +65,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
>  		seq_printf(seq, " %lld",
>  			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(=
i)]));
>  	}
> +	seq_printf(seq, "\nwdeleg_getattr %lld",
> +		percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETAT=
TR]));
> =20
>  	seq_putc(seq, '\n');
>  #endif
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index 9b43dc3d9991..cf5524e7ca06 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -22,6 +22,7 @@ enum {
>  	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
>  	NFSD_STATS_LAST_NFS4_OP =3D NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
>  #define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
> +	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
>  #endif
>  	NFSD_STATS_COUNTERS_NUM
>  };
> @@ -93,4 +94,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct=
 nfsd_net *nn, s64 amount)
>  	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
>  }
> =20
> +#ifdef CONFIG_NFSD_V4
> +static inline void nfsd_stats_wdeleg_getattr_inc(void)
> +{
> +	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
> +}
> +#endif
>  #endif /* _NFSD_STATS_H */

Personally, I think it would still be simpler to just do a CB_GETATTR.
We are issuing a callback in either case, but recalling the delegation
seems like a less optimal outcome.

Still for an interim step, this is fine...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
