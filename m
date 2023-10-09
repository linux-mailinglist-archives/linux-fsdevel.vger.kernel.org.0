Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597587BD3FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJIHBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345360AbjJIHBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:01:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5995AB6;
        Mon,  9 Oct 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0IYgwXkHxIZFTugbTCqxDfQPrCB+iI+n0fYX5mRFmL4=; b=uN3+d/fUiWMYniHiw5gwj8ZjXZ
        iJhe3ZGattrnpY1y5+u+B0DDgspu87fg3SMLPXo5RsSyV6fygk6Qrf1Npfws2c/CaKuM2APuHr16+
        rXq1+naqDEhhlqEk8C9hmXWX4m+gL8tkPQ/F3wbi5vaoF5tyHvSVYHliKA4rt9g9DHZRjZZPfwOfc
        HnaUvkWnruwi9SMIOUmLJkPUUtNenRbnsOZ6ykRWr0tjZBurVDeEwFAl5Nn6TZAGQCK9Ig+AmdDoI
        dVcIA7TyUWMWObHPTZkgflv7W1aORHvziD25wONr8CRBt0/5CHuScLvM/8xi/HwbBCMLKf+kfzx1N
        lgrOO8+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qpkG0-00H7Yw-1F;
        Mon, 09 Oct 2023 07:00:48 +0000
Date:   Mon, 9 Oct 2023 08:00:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs: create helper file_user_path() for user
 displayed mapped file path
Message-ID: <20231009070048.GG800259@ZenIV>
References: <20231007084433.1417887-1-amir73il@gmail.com>
 <20231007084433.1417887-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007084433.1417887-3-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:44:32AM +0300, Amir Goldstein wrote:

> @@ -93,7 +93,8 @@ static void show_faulting_vma(unsigned long address)
>  		char *nm = "?";
>  
>  		if (vma->vm_file) {
> -			nm = file_path(vma->vm_file, buf, ARC_PATH_MAX-1);
> +			nm = d_path(file_user_path(vma->vm_file), buf,
> +				    ARC_PATH_MAX-1);
>  			if (IS_ERR(nm))
>  				nm = "?";

Umm...  At one point I considered this:
	if (vma->vm_file)
                pr_info("  @off 0x%lx in [%pD]  VMA: 0x%08lx to 0x%08lx\n",
                        vma->vm_start < TASK_UNMAPPED_BASE ?
                                address : address - vma->vm_start,
                        vma->vm_file, vma->vm_start, vma->vm_end);
	else
                pr_info("  @off 0x%lx in [anon]  VMA: 0x%08lx to 0x%08lx\n",
                        vma->vm_start < TASK_UNMAPPED_BASE ?
                                address : address - vma->vm_start,
                        vma->vm_start, vma->vm_end);
and to hell with that 'buf' thing...
