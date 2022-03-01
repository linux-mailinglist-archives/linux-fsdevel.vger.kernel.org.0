Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1D14C8D1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiCAN5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiCAN5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:57:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B079BAE4;
        Tue,  1 Mar 2022 05:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F422361516;
        Tue,  1 Mar 2022 13:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC43FC340EE;
        Tue,  1 Mar 2022 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646143024;
        bh=K9qPGj/S8sg1VF+h27APkKAgMBS7LW7PA7Uq1FQ2s8Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bAitthsrTF2NvkACp8filaLE40/3FV1tKMuhBHUpJ6L+eCBZfnRdKRIxYZwpb07+j
         gGFXPAUxAeYPqVMXrSVrnOobkRO80P/1IdWIyyVa+FPdRjCipud2t9jloGO7LMRgiA
         SKapJ5iSvrPB2qaew4C0vvKav7PCjJjuP9kE7jocG97yQRvWvQ3R7cG2IoVwEun8NH
         Y35HDacuyGZueIlo6J3FvRcO/2ZuXCqQJoFfBwusQ5VnBtp0CLLJsMFBdxSBJafgLI
         1K0zqN/J0r7Gvrct8tAuFS88J/h+qiT2rZbmEVahLPETsoIM2Hsbeat6vTRxDpme7l
         zpJkShZ6nVsTQ==
Message-ID: <227b08a2f92ba03badfb81a282c10f60440fdb73.camel@kernel.org>
Subject: Re: [RFC PATCH v10 11/48] ceph: decode alternate_name in lease info
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Date:   Tue, 01 Mar 2022 08:57:02 -0500
In-Reply-To: <77168a2e-1ce4-9924-17ee-7ac58c0fc996@redhat.com>
References: <20220111191608.88762-1-jlayton@kernel.org>
         <20220111191608.88762-12-jlayton@kernel.org>
         <ae096a5b-2f2e-c392-e598-59fd82b44734@redhat.com>
         <c5c1cf58efbbef6e13a2a7ca067ffaeeae15c1d4.camel@kernel.org>
         <77168a2e-1ce4-9924-17ee-7ac58c0fc996@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-01 at 21:51 +0800, Xiubo Li wrote:
> On 3/1/22 9:10 PM, Jeff Layton wrote:
> > On Tue, 2022-03-01 at 18:57 +0800, Xiubo Li wrote:
> > > On 1/12/22 3:15 AM, Jeff Layton wrote:
> > > > Ceph is a bit different from local filesystems, in that we don't want
> > > > to store filenames as raw binary data, since we may also be dealing
> > > > with clients that don't support fscrypt.
> > > > 
> > > > We could just base64-encode the encrypted filenames, but that could
> > > > leave us with filenames longer than NAME_MAX. It turns out that the
> > > > MDS doesn't care much about filename length, but the clients do.
> > > > 
> > > > To manage this, we've added a new "alternate name" field that can be
> > > > optionally added to any dentry that we'll use to store the binary
> > > > crypttext of the filename if its base64-encoded value will be longer
> > > > than NAME_MAX. When a dentry has one of these names attached, the MDS
> > > > will send it along in the lease info, which we can then store for
> > > > later usage.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >    fs/ceph/mds_client.c | 40 ++++++++++++++++++++++++++++++----------
> > > >    fs/ceph/mds_client.h | 11 +++++++----
> > > >    2 files changed, 37 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > index 34a4f6dbac9d..709f3f654555 100644
> > > > --- a/fs/ceph/mds_client.c
> > > > +++ b/fs/ceph/mds_client.c
> > > > @@ -306,27 +306,44 @@ static int parse_reply_info_dir(void **p, void *end,
> > > >    
> > > >    static int parse_reply_info_lease(void **p, void *end,
> > > >    				  struct ceph_mds_reply_lease **lease,
> > > > -				  u64 features)
> > > > +				  u64 features, u32 *altname_len, u8 **altname)
> > > >    {
> > > > +	u8 struct_v;
> > > > +	u32 struct_len;
> > > > +
> > > >    	if (features == (u64)-1) {
> > > > -		u8 struct_v, struct_compat;
> > > > -		u32 struct_len;
> > > > +		u8 struct_compat;
> > > > +
> > > >    		ceph_decode_8_safe(p, end, struct_v, bad);
> > > >    		ceph_decode_8_safe(p, end, struct_compat, bad);
> > > > +
> > > >    		/* struct_v is expected to be >= 1. we only understand
> > > >    		 * encoding whose struct_compat == 1. */
> > > >    		if (!struct_v || struct_compat != 1)
> > > >    			goto bad;
> > > > +
> > > >    		ceph_decode_32_safe(p, end, struct_len, bad);
> > > > -		ceph_decode_need(p, end, struct_len, bad);
> > > > -		end = *p + struct_len;
> > > Hi Jeff,
> > > 
> > > This is buggy, more detail please see https://tracker.ceph.com/issues/54430.
> > > 
> > > The following patch will fix it. We should skip the extra memories anyway.
> > > 
> > > 
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 94b4c6508044..3dea96df4769 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -326,6 +326,7 @@ static int parse_reply_info_lease(void **p, void *end,
> > >                           goto bad;
> > > 
> > >                   ceph_decode_32_safe(p, end, struct_len, bad);
> > > +               end = *p + struct_len;
> > 
> > There may be a bug here,
> 
> Yeah, this will be crash when I use the PR 
> https://github.com/ceph/ceph/pull/45208.
> 
> 
> > but this doesn't look like the right fix. "end"
> > denotes the end of the buffer we're decoding. We don't generally want to
> > go changing it like this. Consider what would happen if the original
> > "end" was shorter than *p + struct_len.
> I missed you have also set the struct_len in the else branch.
> > 
> > >           } else {
> > >                   struct_len = sizeof(**lease);
> > >                   *altname_len = 0;
> > > @@ -346,6 +347,7 @@ static int parse_reply_info_lease(void **p, void *end,
> > >                           *altname = NULL;
> > >                           *altname_len = 0;
> > >                   }
> > > +               *p = end;
> > 
> > I think we just have to do the math here. Maybe this should be something
> > like this?
> > 
> >      *p += struct_len - sizeof(**lease) - *altname_len;
> 
> This is correct, but in future if we are adding tens of new fields we 
> must minus them all here.
> 
> How about this one:
> 
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 94b4c6508044..608d077f2eeb 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -313,6 +313,7 @@ static int parse_reply_info_lease(void **p, void *end,
>   {
>          u8 struct_v;
>          u32 struct_len;
> +       void *lend;
> 
>          if (features == (u64)-1) {
>                  u8 struct_compat;
> @@ -332,6 +333,7 @@ static int parse_reply_info_lease(void **p, void *end,
>                  *altname = NULL;
>          }
> 
> +       lend = *p + struct_len;


Looks reasonable. Maybe also add a check like this?

    if (lend > end)
	    return -EIO;


>          ceph_decode_need(p, end, struct_len, bad);
>          *lease = *p;
>          *p += sizeof(**lease);
> @@ -347,6 +349,7 @@ static int parse_reply_info_lease(void **p, void *end,
>                          *altname_len = 0;
>                  }
>          }
> +       *p = lend;
>          return 0;
>   bad:
>          return -EIO;
> 
> 

> > >           }
> > >           return 0;
> > >    bad:
> > > 
> > > 
> > > 
> > 
> > > > +	} else {
> > > > +		struct_len = sizeof(**lease);
> > > > +		*altname_len = 0;
> > > > +		*altname = NULL;
> > > >    	}
> > > >    
> > > > -	ceph_decode_need(p, end, sizeof(**lease), bad);
> > > > +	ceph_decode_need(p, end, struct_len, bad);
> > > >    	*lease = *p;
> > > >    	*p += sizeof(**lease);
> > > > -	if (features == (u64)-1)
> > > > -		*p = end;
> > > > +
> > > > +	if (features == (u64)-1) {
> > > > +		if (struct_v >= 2) {
> > > > +			ceph_decode_32_safe(p, end, *altname_len, bad);
> > > > +			ceph_decode_need(p, end, *altname_len, bad);
> > > > +			*altname = *p;
> > > > +			*p += *altname_len;
> > > > +		} else {
> > > > +			*altname = NULL;
> > > > +			*altname_len = 0;
> > > > +		}
> > > > +	}
> > > >    	return 0;
> > > >    bad:
> > > >    	return -EIO;
> > > > @@ -356,7 +373,8 @@ static int parse_reply_info_trace(void **p, void *end,
> > > >    		info->dname = *p;
> > > >    		*p += info->dname_len;
> > > >    
> > > > -		err = parse_reply_info_lease(p, end, &info->dlease, features);
> > > > +		err = parse_reply_info_lease(p, end, &info->dlease, features,
> > > > +					     &info->altname_len, &info->altname);
> > > >    		if (err < 0)
> > > >    			goto out_bad;
> > > >    	}
> > > > @@ -423,9 +441,11 @@ static int parse_reply_info_readdir(void **p, void *end,
> > > >    		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
> > > >    
> > > >    		/* dentry lease */
> > > > -		err = parse_reply_info_lease(p, end, &rde->lease, features);
> > > > +		err = parse_reply_info_lease(p, end, &rde->lease, features,
> > > > +					     &rde->altname_len, &rde->altname);
> > > >    		if (err)
> > > >    			goto out_bad;
> > > > +
> > > >    		/* inode */
> > > >    		err = parse_reply_info_in(p, end, &rde->inode, features);
> > > >    		if (err < 0)
> > > > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > > > index e7d2c8a1b9c1..128901a847af 100644
> > > > --- a/fs/ceph/mds_client.h
> > > > +++ b/fs/ceph/mds_client.h
> > > > @@ -29,8 +29,8 @@ enum ceph_feature_type {
> > > >    	CEPHFS_FEATURE_MULTI_RECONNECT,
> > > >    	CEPHFS_FEATURE_DELEG_INO,
> > > >    	CEPHFS_FEATURE_METRIC_COLLECT,
> > > > -
> > > > -	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
> > > > +	CEPHFS_FEATURE_ALTERNATE_NAME,
> > > > +	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_ALTERNATE_NAME,
> > > >    };
> > > >    
> > > >    /*
> > > > @@ -45,8 +45,7 @@ enum ceph_feature_type {
> > > >    	CEPHFS_FEATURE_MULTI_RECONNECT,		\
> > > >    	CEPHFS_FEATURE_DELEG_INO,		\
> > > >    	CEPHFS_FEATURE_METRIC_COLLECT,		\
> > > > -						\
> > > > -	CEPHFS_FEATURE_MAX,			\
> > > > +	CEPHFS_FEATURE_ALTERNATE_NAME,		\
> > > >    }
> > > >    #define CEPHFS_FEATURES_CLIENT_REQUIRED {}
> > > >    
> > > > @@ -98,7 +97,9 @@ struct ceph_mds_reply_info_in {
> > > >    
> > > >    struct ceph_mds_reply_dir_entry {
> > > >    	char                          *name;
> > > > +	u8			      *altname;
> > > >    	u32                           name_len;
> > > > +	u32			      altname_len;
> > > >    	struct ceph_mds_reply_lease   *lease;
> > > >    	struct ceph_mds_reply_info_in inode;
> > > >    	loff_t			      offset;
> > > > @@ -117,7 +118,9 @@ struct ceph_mds_reply_info_parsed {
> > > >    	struct ceph_mds_reply_info_in diri, targeti;
> > > >    	struct ceph_mds_reply_dirfrag *dirfrag;
> > > >    	char                          *dname;
> > > > +	u8			      *altname;
> > > >    	u32                           dname_len;
> > > > +	u32                           altname_len;
> > > >    	struct ceph_mds_reply_lease   *dlease;
> > > >    
> > > >    	/* extra */
> 

-- 
Jeff Layton <jlayton@kernel.org>
