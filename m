Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7264EFA2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiDASxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiDASxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AD40922;
        Fri,  1 Apr 2022 11:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E1161501;
        Fri,  1 Apr 2022 18:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDAC340EC;
        Fri,  1 Apr 2022 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648839110;
        bh=GE/McCjK3IGVMdGkmFi2pR048UwzrFF4XF6/lfZGdDk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kxITNO7glrtSZRHpI/hJmZ0fHEwLkhSAoc2bRa/5YNP6dfmobC2NUUNTA/devjXtS
         daqtl1y3U941PoOyfIkWtbBs42b9jy2IuVS52qV4ySIDA1CvKE1qwnuJtisorWIWvY
         dOxDODal3Uxqpt6POaCBsjlyjfL2GS1o7VivnUgIlrZ1Y2vqs9H0kYZ6IO5Hbsd9TR
         X5C65ph0gp8XHL0wM8SWqtIJG379iaRWBkl+SVll3lrvDHOf3eDg5/eVnLjRjcxkgU
         Yg8LrV0A9uTVUOku8lLagfWM6i4DSdzEGv+fwJf1Jv1y6iIZO9ZP7ZS9LLnEoOT9Dt
         L43w3ADPe08wQ==
Message-ID: <9204ba17ec7eff56d4789c35f99fc6bf6a2edbc7.camel@kernel.org>
Subject: Re: [PATCH v12 08/54] ceph: add a has_stable_inodes operation for
 ceph
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Apr 2022 14:51:48 -0400
In-Reply-To: <YkdBfkqlSUzJlNHD@gmail.com>
References: <20220331153130.41287-1-jlayton@kernel.org>
         <20220331153130.41287-9-jlayton@kernel.org> <YkYJF07WdQZoucQ5@gmail.com>
         <0d9311b16cae47f7a1eb417d589adc093d9dc5b9.camel@kernel.org>
         <YkdBfkqlSUzJlNHD@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

On Fri, 2022-04-01 at 18:16 +0000, Eric Biggers wrote:
> On Fri, Apr 01, 2022 at 06:37:10AM -0400, Jeff Layton wrote:
> > On Thu, 2022-03-31 at 20:03 +0000, Eric Biggers wrote:
> > > On Thu, Mar 31, 2022 at 11:30:44AM -0400, Jeff Layton wrote:
> > > >  static struct fscrypt_operations ceph_fscrypt_ops = {
> > > >  	.key_prefix		= "ceph:",
> > > >  	.get_context		= ceph_crypt_get_context,
> > > >  	.set_context		= ceph_crypt_set_context,
> > > >  	.empty_dir		= ceph_crypt_empty_dir,
> > > > +	.has_stable_inodes	= ceph_crypt_has_stable_inodes,
> > > >  };
> > > 
> > > What is the use case for implementing this?  Note the comment in the struct
> > > definition:
> > > 
> > >        /*
> > >          * Check whether the filesystem's inode numbers and UUID are stable,
> > >          * meaning that they will never be changed even by offline operations
> > >          * such as filesystem shrinking and therefore can be used in the
> > >          * encryption without the possibility of files becoming unreadable.
> > >          *
> > >          * Filesystems only need to implement this function if they want to
> > >          * support the FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64} flags.  These
> > >          * flags are designed to work around the limitations of UFS and eMMC
> > >          * inline crypto hardware, and they shouldn't be used in scenarios where
> > >          * such hardware isn't being used.
> > >          *
> > >          * Leaving this NULL is equivalent to always returning false.
> > >          */
> > >         bool (*has_stable_inodes)(struct super_block *sb);
> > > 
> > > I think you should just leave this NULL for now.
> > > 
> > 
> > Mostly we were just looking for ways to make all of the -g encrypt
> > xfstests pass. I'll plan to drop this patch and 07/54. I don't see any
> > need to support legacy modes or stuff that involves special storage hw.
> 
> Do generic/592 and generic/602 fail without this patch?  If so, that would be a
> test bug, since they should be skipped if the filesystem doesn't support
> FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32}.  I think that
> _require_encryption_policy_support() should be already taking care of that,
> though?
> 


My mistake. Those are just skipped with that patch dropped.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
