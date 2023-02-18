Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A813269B898
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBRICM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBRICK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:02:10 -0500
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Feb 2023 00:02:09 PST
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637A4DE2C;
        Sat, 18 Feb 2023 00:02:09 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6ED44C01F; Sat, 18 Feb 2023 09:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676707352; bh=xnzLbTiXqlMf+/EQqFeN+eC4zTGzFsvB7LNLEwOsaew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWObbccqUVwnrnZKbKh6ZOWPmxNbmmXFuJKxCQJiUCfwN4dIx+u4amdec2aV7ZcBU
         Ng9jlkp7i3ijPeMF09zSK2caIBvZ97y3k7qafOTwLJX9d2xrUXxyxs/u5DsWbtXySG
         EHatYpEc/Fjo+BGutf9PWyR930b69g0TEJrc7xTEUMggcZdvphhm3JRNbrbaNb5j+s
         /faOD2oi7lMzHvqTFevkcWxd+pUp/nme98TniQA3a0FJMo+nw2mQZQ9/ZaOrko4Tsp
         APT5By8dB71S/Uso2uta8uPWyInsdGgCteTP9EFla34+k9LXgWIG79d5+7CvKF3w6c
         twOZbmaXWZBuw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id ECF36C009;
        Sat, 18 Feb 2023 09:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676707351; bh=xnzLbTiXqlMf+/EQqFeN+eC4zTGzFsvB7LNLEwOsaew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7LOd713p3DcFe5glsQv0d5pUSxWT7E4CabcHHS5oRu8saRN/ArmdYQHWLhtYXxuG
         rvwtEuwJXHQdPNVeT5XEeVR+NktSxUeqXiKpnusdCH68d2PL52XiVQq0yPSfyhq0OK
         pjc+Dctu2F+XfM2JN9EGd+n36OaU7qV1lFjIsKMRYil9SaX205YsEP2v4ZvNqG1Agx
         YO7mC17LhFaTKEJC/NnB/fYCUHI17W+vMrD4xE2ohxEO269duy46f5FTAE+EkzWUQ0
         OEroBfYuWUpZErsQvmwzUdLEQyYW5WLc2Khy7o14oBhwIZ6RJr1YdStialfiaC2U21
         sbeoRMQmMnh5g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a6e04029;
        Sat, 18 Feb 2023 08:02:02 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:01:47 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 06/11] net/9p: fix bug in client create for .L
Message-ID: <Y/CF64nDuhoJtCmj@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-7-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-7-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:18AM +0000:
> We are supposed to set fid->mode to reflect the flags
> that were used to open the file.  We were actually setting
> it to the creation mode which is the default perms of the
> file not the flags the file was opened with.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

I was about to say fcreate has the same problem, but TCREATE's mode
actually is the open mode (0 (called OREAD), 1 (OWRITE), 2 (ORDWR), and
3 (OEXEC)) and dotl's create is called perm :|

I guess that's where the mistake came from... Good catch!
(and there's also p9_wstat's mode which also is the perms to make things
more confusing...)


Anyway,
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
