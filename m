Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148977C9E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjHOJA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjHOI7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AF1BC0;
        Tue, 15 Aug 2023 01:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4023263E2F;
        Tue, 15 Aug 2023 08:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C15C433C7;
        Tue, 15 Aug 2023 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692089969;
        bh=MArXAIr8c9w9SGHAmRMmXFdx0pibI2BQaL9ZvGmfZ+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5eMKztoKIGPUroWlu0kDWQckmc28nItr01rFT5I4CClgh1M1uBGGsZnH0LVIWtxQ
         qbyNyWmOigSmPPXS//NsFqZ9z6h+6rRzHjkCFmltOp/mkVdE2AzNOBZUgCaIrPJu+r
         t5DXUaKuPLwXWbvbt2oDhXLrx1ief2b1C0jrRI9DQ9WUBxNdcwtLDipJ3GH9bMJgQM
         fylZxEdJM8GgdaLe3wW0HTPWleupgJAT4B6d5eGuxRTVkc4uyMvaeRpJbJJjLfBl6M
         RiNcn4YA86xiFhW6ycuJCQ+Xt9h3rNTaqz3fqPDb+/mnBoD5TArukWBsYwS9HDsJJg
         Is5XzyeFf2jLA==
Date:   Tue, 15 Aug 2023 10:59:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gyroidos@aisec.fraunhofer.de
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Message-ID: <20230815-feigling-kopfsache-56c2d31275bd@brauner>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:26:09PM +0200, Michael Weiß wrote:
> Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
> which allows to set a cgroup device program to be a device guard.

Currently we block access to devices unconditionally in may_open_dev().
Anything that's mounted by an unprivileged containers will get
SB_I_NODEV set in s_i_flags.

Then we currently mediate device access in:

* inode_permission()
  -> devcgroup_inode_permission()
* vfs_mknod()
  -> devcgroup_inode_mknod()
* blkdev_get_by_dev() // sget()/sget_fc(), other ways to open block devices and friends
  -> devcgroup_check_permission()
* drivers/gpu/drm/amd/amdkfd // weird restrictions on showing gpu info afaict
  -> devcgroup_check_permission()

All your new flag does is to bypass that SB_I_NODEV check afaict and let
it proceed to the devcgroup_*() checks for the vfs layer.

But I don't get the semantics yet.
Is that a flag which is set on BPF_PROG_TYPE_CGROUP_DEVICE programs or
is that a flag on random bpf programs? It looks like it would be the
latter but design-wise I would expect this to be a property of the
device program itself.
