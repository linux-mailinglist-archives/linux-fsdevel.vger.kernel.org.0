Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2754319F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbiFHNlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiFHNlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3BE11DC87F
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654695662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FRvLtHpL+lFu/Ve4k0BDHQ9OKaNS8tYQAlmzPxz+uc=;
        b=M7IPI8OZhGSPhl2NIIhtw5FoOqn4eUrPHDkizp+mMT4nnHHzzC3jHq+VywruYW7RMFqesW
        S+pCp1fv9fN4fzG8lzwNxDqvjTrzx8fwNiHj5SX4ZLrGD756bmLSKWaN16aeh8/300o10y
        wqBcTySTxcOYDu76EM8VftLbG2XPpaQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-WWnTU5i9PAeCXfPzyrqR6Q-1; Wed, 08 Jun 2022 09:40:57 -0400
X-MC-Unique: WWnTU5i9PAeCXfPzyrqR6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 748FB3C0E203;
        Wed,  8 Jun 2022 13:40:57 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-0-4.rdu2.redhat.com [10.22.0.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A683492C3B;
        Wed,  8 Jun 2022 13:40:56 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Roberto Bergantinos Corpas" <rbergant@redhat.com>
Subject: Re: vfs_test_lock - should it WARN if F_UNLCK and modified file_lock?
Date:   Wed, 08 Jun 2022 09:40:54 -0400
Message-ID: <2E73BEEA-C668-4C62-BCEA-D85F31DC89F8@redhat.com>
In-Reply-To: <20220608133655.GA13884@fieldses.org>
References: <9559FAE9-4E4A-4161-995F-32D800EC0D5B@redhat.com>
 <20220608133655.GA13884@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8 Jun 2022, at 9:36, J. Bruce Fields wrote:

> On Wed, Jun 08, 2022 at 09:19:25AM -0400, Benjamin Coddington wrote:
>> NLM sometimes gets burnt by implementations of f_op->lock for F_GETLK
>> modifying the lock structure (swapping out fl_owner) when the return is
>> F_UNLCK.
>>
>> Yes, NLM should be more defensive, but perhaps we should be checking for
>> everyone, as per POSIX "If no lock is found that would prevent this lock
>> from being created, then the structure shall be left unchanged
>> except for
>> the lock type which shall be set to F_UNLCK."
>
> Doesn't seem like changing fl_owner affects fcntl_getlk results in this
> case, so I don't think posix applies?  Though, OK, maybe it violates the
> principle of least surprise for vfs_test_lock to behave differently.

Oh yeah, good point.  fl_owner is just internal.  That's enough of a reason
for me to drop this idea.

Ben

