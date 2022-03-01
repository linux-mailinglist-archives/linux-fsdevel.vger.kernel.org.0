Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808384C9210
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiCARlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 12:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiCARlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:41:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9E48338;
        Tue,  1 Mar 2022 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CBxj1BkjQUCaP73DP+hxiU/eYRNf4EfoIsH9x0KIu0g=; b=3mqo/obC4/6t+GgoQN5XECWrnL
        npLAfe/TUHHwrEKwj0oAzlv3iWXKAvzRdCMhL7OicR+jST7uTRan13xIRYJgusLH1q1b2CSLoAa4r
        SxF4CyIYtzviOZft1GCM2Yt7PKykIdMGn2KRkhOz7Nx0F2h4E1lIiTKc1DJd+IUVqUkSCUKy7mITJ
        CxvSR0EJ4ddAoDV2Bfg0SuzamVxCCVcWN5TFgoRmJJmfltuUbGpqIbVkVqQyJaz+DcizB0nS8zmfc
        y5+DlK3wJcfBCMjRhvRNiH9WK524OYu1csC1zRh2mwA/+TJL9FSDyD+qi1oWJ9OmP11dmQxFecu1D
        M2XPXSvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP6Tt-0005t2-VB; Tue, 01 Mar 2022 17:40:13 +0000
Date:   Tue, 1 Mar 2022 09:40:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh5afaKFt0bmIs96@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
 <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
 <3136665a674acd1c1cc18f12802684bf82fc8e36.camel@HansenPartnership.com>
 <Yh5PdGxnnVru2/go@bombadil.infradead.org>
 <9735af01b28f73762a947a0794da63ae35bc06e0.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9735af01b28f73762a947a0794da63ae35bc06e0.camel@HansenPartnership.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:14:49PM -0500, James Bottomley wrote:
> It looks fairly similar given the iouring syscalls are on an fd except
> that the structure above hash to be defined and becomes an ABI.  Since
> they configfd uses typed key value pairs, i'd argue it's more generic
> and introspectable.

I'm not suggesting using io-uring cmd as a configuration alternative
to configfd, I'm suggesting it can be an async *vehicle* for a bunch
of configurations one might need to make in the kernel. If we want
to reduce system call uses, we may want to allow something like configfd
to accept a batch of configuration options as well, as a batcha, and a
final commit to process them.

  Luis
