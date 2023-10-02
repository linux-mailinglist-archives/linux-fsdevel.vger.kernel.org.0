Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00567B4ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjJBCxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjJBCxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:53:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5CC9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xINw1YgO8R1t3kZBiNeV3AnsQ8IWjQIrzX/uhoLsmfs=; b=sputEP/Exdr3ON8hagHBxxXwIk
        ykcAxlvPTVrwOkYSC1FD2rnDr6/3WnXDx/9/dfYaQ0Fqe/BIH9ptc04jUDnQiP1bP6B4hu3p2LORd
        wkT3wLVXMRMmMxPmW8XfVWhfJSnqMgsXAXaM8UyreDCtmvdww1xF8Cbg8kWzHKed3/2ZGmoYTKTyP
        s/mJ5vmfAQDnRUSoO8DQT9J/OS2evsuV6Har299xXQuQPwlyMJ2n0ZzeRYT5cGkJIseWhmNiwvPHj
        3YfIXqZHLUJxk1H3loggFvq3P4Yw4/JogdRNqYmWfWHrJdoaG248aYBeJjpn7/OiZ0m6eUxNFQDW9
        dIfOK3zg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn93I-00EEDA-2w;
        Mon, 02 Oct 2023 02:52:57 +0000
Date:   Mon, 2 Oct 2023 03:52:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC][PATCHES] fixes in methods exposed to rcu pathwalk
Message-ID: <20231002025256.GR800259@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PS: ceph ->d_revalidate() uses ->s_fs_info and stuff hanging off it
(mdsc) and I'm not familiar enough with the codebase to do anything
useful with it; AFAICS, there are UAF on fs shutdown, but I'd rather
leave that one to ceph folks.  NTFS3 ->d_hash() and ->d_compare()
do blocking allocations, and that stuff can be called under
rcu_read_lock(); ->d_compare() pretty much always is called so...
