Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DDB6E2A63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNTB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNTBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2831213A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681498866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDjTR4W4QJJ8lrexEDMtF9xBKiiiN6ss3zxDd4U1Dc0=;
        b=CcjcKcQz//cGE/Uxy01gCX5pOcY0ihYfbAjqwRcjsARXBjFncU6cnaO0CG5CVGguxWyXI4
        /cQ+mT+LCGcHARVeyW8kWj7sZpG7QO9NihErLL5LbrFzxWoJEFnWNfv8ZO/epogTvESih/
        34Rli2dM8wQAqwyh0coA4Ejw8oSSV0s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-fCzJ1CmvMEm-8Ukfj5p4rw-1; Fri, 14 Apr 2023 15:01:05 -0400
X-MC-Unique: fCzJ1CmvMEm-8Ukfj5p4rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7B391C0898E;
        Fri, 14 Apr 2023 19:01:04 +0000 (UTC)
Received: from [172.16.193.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25736C16028;
        Fri, 14 Apr 2023 19:01:02 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeffrey Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: allowing for a completely cached umount(2) pathwalk
Date:   Fri, 14 Apr 2023 15:01:01 -0400
Message-ID: <6F3DB6E1-F104-492B-9AF1-5AEC8C27D267@redhat.com>
In-Reply-To: <E746F6B4-779A-4184-A2A7-5879E3D3DAEE@hammerspace.com>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV>
 <2631cb9c05087ddd917679b7cebc58cb42cd2de6.camel@kernel.org>
 <20230414-sowas-unmittelbar-67fdae9ca5cd@brauner>
 <9192A185-03BF-4062-B12F-E7EF52578014@hammerspace.com>
 <20230414-leiht-lektion-18f5a7a38306@brauner>
 <91D4AC04-A016-48A9-8E3A-BBB6C38E8C4B@hammerspace.com>
 <4F4F5C98-AA06-40FB-AE51-79E860CD1D76@hammerspace.com>
 <20230414162253.GL3390869@ZenIV>
 <E746F6B4-779A-4184-A2A7-5879E3D3DAEE@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14 Apr 2023, at 12:41, Trond Myklebust wrote:
>
> I mean both cases. Doing a lazy umount with a hard mounted filesystem i=
s a risk sport: if the server does become permanently borked, you can fil=
l up your page cache with stuff that can=E2=80=99t be evicted. Most users=
 don=E2=80=99t realise this, so they get confused when it happens (partic=
ularly since the filesystem is out-of-sight and hence out-of-mind).

I've been pecking away at a sysfs knob for this case.  Seemed a clearer p=
ath to destruction.

>>
>> Note, BTW, that hard vs. soft is a property of fs instance; if you hav=
e
>> it present elsewhere in the mount tree, flipping it would affect all
>> such places.  I don't see any good way to make it a per-mount thing, T=
BH=E2=80=A6
>
>
> The main use case is for when the server is permanently down, so normal=
ly it shouldn=E2=80=99t be a problem with flipping the mode on all instan=
ces.

Is there another case?  Because, if so..

> That said, it might be nice to make it per-mountpoint at some time. We =
do have the ability to declare individual RPC calls to time out, so it=E2=
=80=99s doable at the RPC level. All we would really need is the ability =
to store a per-vfsmount flag.

=2E. maybe vfsmount's mnt_root d_fsdata?

Ben

