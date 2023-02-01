Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8236E686709
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjBANhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBANhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:37:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB010F7;
        Wed,  1 Feb 2023 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+KZHp1jKXys/dV6xJC6crmtQWDDsv7KCPO1b9rtXp0k=; b=xnTZOLWWg7ILYx1AWRqGQgtNX/
        137HSpNtcyLKMGKmR7HZhGkc1yi29pXEa0wMrS7awyQJCaa8dVtHIFYiCSPmSMxUlhZLodvWJVgCO
        QmFWF4p01m7P+qLn5DwF+2HxioDXDWhoL95T+zfvCEoh2qnCvaeUuOXOGR/eHrDVP56tmiJEERUnk
        GeujjsKUrH9tiwujNzbsGoZ+0iztpS+XIsZHncegBE5LRQJn9qDq1LgApWbwXYcCU4+TJzUi16aGe
        se6ieZY/Xk67Z9q7N8nbQcmYSP4KUe2SdKwu4YBi1rsy8XCWpfXPTP5iV4yyL0WO9jIv18wngbx1h
        9ITLUnZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDII-00C6X8-0C; Wed, 01 Feb 2023 13:36:58 +0000
Date:   Wed, 1 Feb 2023 05:36:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 11/12] cifs: Fix problem with encrypted RDMA data read
Message-ID: <Y9pq+YUf/iFE8JUC@infradead.org>
References: <20230131182855.4027499-1-dhowells@redhat.com>
 <20230131182855.4027499-12-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131182855.4027499-12-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:28:54PM +0000, David Howells wrote:
> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
> server has "smb3 encryption = yes" in its config file, the normal PDU
> stream is encrypted, but the directly-delivered data isn't in the stream
> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
> least with IWarp).

This really needs to be split into a separate backportable fix series.
And it seems like Stefan has just send such a series.
