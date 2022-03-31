Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81934EE243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiCaUF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiCaUF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96222A76DA;
        Thu, 31 Mar 2022 13:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B9561AB0;
        Thu, 31 Mar 2022 20:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69892C340F2;
        Thu, 31 Mar 2022 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648757017;
        bh=RNm5ixSvqvoJM5egiB6aLaJgZgoCMTyAXibips4aPYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSL84hsWrM6G1VU6c+mRbzUfY8ez+m105kXdrwcKZqBibvT6DcO2IyWSR75HCFOFT
         koWNW+Km8gm7rgXNF30zBxg2lo5nuywwPwM+5Vb7tVJurCeAXA861VhmEYe2X1B+4g
         mQdK9WxcQlpCjEFBMBHJoNY9ty7Cqqh3cKN+RNGVZoVbuVR92iEpP+QxIYJvb/zYRh
         lFp95lUKY28Zc0JX4khuled4gRJ8n16lICB9JYqnaNOWfEJz3cD4Nmty2dlII0tH5N
         GP5+lnvnXFFThHHjuAkmOHuFq6U8H9OpwDXCZ1wez5HIGOuu07T0O7aCeXDctNUX4v
         kX8WDgkH9vsCA==
Date:   Thu, 31 Mar 2022 20:03:35 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, xiubli@redhat.com, idryomov@gmail.com,
        lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/54] ceph: add a has_stable_inodes operation for
 ceph
Message-ID: <YkYJF07WdQZoucQ5@gmail.com>
References: <20220331153130.41287-1-jlayton@kernel.org>
 <20220331153130.41287-9-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331153130.41287-9-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:30:44AM -0400, Jeff Layton wrote:
>  static struct fscrypt_operations ceph_fscrypt_ops = {
>  	.key_prefix		= "ceph:",
>  	.get_context		= ceph_crypt_get_context,
>  	.set_context		= ceph_crypt_set_context,
>  	.empty_dir		= ceph_crypt_empty_dir,
> +	.has_stable_inodes	= ceph_crypt_has_stable_inodes,
>  };

What is the use case for implementing this?  Note the comment in the struct
definition:

       /*
         * Check whether the filesystem's inode numbers and UUID are stable,
         * meaning that they will never be changed even by offline operations
         * such as filesystem shrinking and therefore can be used in the
         * encryption without the possibility of files becoming unreadable.
         *
         * Filesystems only need to implement this function if they want to
         * support the FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{32,64} flags.  These
         * flags are designed to work around the limitations of UFS and eMMC
         * inline crypto hardware, and they shouldn't be used in scenarios where
         * such hardware isn't being used.
         *
         * Leaving this NULL is equivalent to always returning false.
         */
        bool (*has_stable_inodes)(struct super_block *sb);

I think you should just leave this NULL for now.

- Eric
