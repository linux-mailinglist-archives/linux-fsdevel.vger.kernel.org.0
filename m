Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F226786DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjAWTx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 14:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjAWTx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391F59EE
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674503563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aze1G6mgWzCcRJXgFNa8HjfCbOTiXXX/A6U9nxgbJkM=;
        b=H27x6PHJI79CNjpb/5RCWHm5jZVNWEpV5QWs5SPSpMDmdS9n60DI9ZBLJqwDhuqp5hzE6k
        gPc84vUu+z0YxhcB4KIw2h/6ggzKbt0IFUgQ1R9hTVujf/ZI2pmvKiTJS1bJGnCDBkVgPG
        GWUtpYNifDhPV8+YhbJQ34GGumORHSk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-JZDVN0L7MfuQFgCDu-fvCA-1; Mon, 23 Jan 2023 14:52:36 -0500
X-MC-Unique: JZDVN0L7MfuQFgCDu-fvCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB437380406A;
        Mon, 23 Jan 2023 19:52:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-192-224.brq.redhat.com [10.40.192.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6618D175A2;
        Mon, 23 Jan 2023 19:52:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Jan 2023 20:52:33 +0100 (CET)
Date:   Mon, 23 Jan 2023 20:52:29 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <20230123195228.GD6268@redhat.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com>
 <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87OEdDXwZG8pmmE@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/23, Gregory Price wrote:
>
> So i think dropping 2/3 in the list is good.  If you concur i'll do
> that.

Well I obviously think that 2/3 should be dropped ;)

As for 1/3 and 3/3, feel free to add my reviewed-by.

Oleg.

