Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB34B2854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbiBKOwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 09:52:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245724AbiBKOwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8D131;
        Fri, 11 Feb 2022 06:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 049C7B82A75;
        Fri, 11 Feb 2022 14:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6DFC340E9;
        Fri, 11 Feb 2022 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644591155;
        bh=F3GpJ6eC6nAG2fUQjoncES3V8qvJcO/nw1ng30P3vi0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OhO7y/aluDHAY44Vsty4HdqZOJQ3NOStynrt09Rejwuts2cveX2kGSEDadVahqytw
         CubSeScFs93oIUMYagMhYq7pBFDJG7qJtycdg+l/6YlocpOX9GCT1e2JX60IhG+PIz
         wWyRaAWhiuhWsPzWGEaGO5/9iUm25JzZYADpHmwJEIBe+gjxAGnbpRzzCK+4sXQCGh
         m6mFo3D3QU/tSMSn85kCayLgf27u2CwY66sPix+PtE/2Du0/GiE+SXOoRc/83hED2P
         ZzNzjjiwuRockRh4D9UDPo8y2vVVr1B/SpnaqoM5IAFTz/vAZkhgBOSkb3ODbt+9Bw
         2FyL8NnOHdjYA==
Message-ID: <f959ba0ab5916b5954fdf96eca49e0a85f581b61.camel@kernel.org>
Subject: Re: [RFC PATCH v10 10/48] ceph: implement -o test_dummy_encryption
 mount option
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Date:   Fri, 11 Feb 2022 09:52:34 -0500
In-Reply-To: <87h795v7fn.fsf@brahms.olymp>
References: <20220111191608.88762-1-jlayton@kernel.org>
         <20220111191608.88762-11-jlayton@kernel.org> <87h795v7fn.fsf@brahms.olymp>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-02-11 at 13:50 +0000, Luís Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/crypto.c | 53 ++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 26 ++++++++++++++++
> >  fs/ceph/inode.c  | 10 ++++--
> >  fs/ceph/super.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/ceph/super.h  | 12 +++++++-
> >  fs/ceph/xattr.c  |  3 ++
> >  6 files changed, 177 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index a513ff373b13..017f31eacb74 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/fscrypt.h>
> >  
> >  #include "super.h"
> > +#include "mds_client.h"
> >  #include "crypto.h"
> >  
> >  static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
> > @@ -64,9 +65,20 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
> >  	return ci->i_rsubdirs + ci->i_rfiles == 1;
> >  }
> >  
> > +void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
> > +{
> > +	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
> > +}
> > +
> > +static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
> > +{
> > +	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
> > +}
> > +
> >  static struct fscrypt_operations ceph_fscrypt_ops = {
> >  	.get_context		= ceph_crypt_get_context,
> >  	.set_context		= ceph_crypt_set_context,
> > +	.get_dummy_policy	= ceph_get_dummy_policy,
> >  	.empty_dir		= ceph_crypt_empty_dir,
> >  };
> >  
> > @@ -74,3 +86,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
> >  {
> >  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
> >  }
> > +
> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +				 struct ceph_acl_sec_ctx *as)
> > +{
> > +	int ret, ctxsize;
> > +	bool encrypted = false;
> > +	struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
> > +	if (ret)
> > +		return ret;
> > +	if (!encrypted)
> > +		return 0;
> > +
> > +	as->fscrypt_auth = kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
> > +	if (!as->fscrypt_auth)
> > +		return -ENOMEM;
> > +
> 
> Isn't this memory allocation leaking bellow in the error paths?
> 
> (Yeah, I'm finally (but slowly) catching up with this series... my memory
> is blurry and there are a lot of things I forgot...)
> 
> Cheers,

No. If an error bubbles back up here, we'll eventually call
ceph_release_acl_sec_ctx on the thing, and it'll be kfreed then.
-- 
Jeff Layton <jlayton@kernel.org>
