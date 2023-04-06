Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCAE6DA159
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDFTdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDFTdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:33:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015E4C32;
        Thu,  6 Apr 2023 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bfc4MoxW69RqNoXmXDlX2wXhjgD6wTy+Du4f8wMhNOE=; b=RE4JvnuJdOiiDzo0+bGjHnNo8o
        I6MtnTr/k0Ih20Bvw9bFO/5JvApWU62xkw99vBbM6QWwWu1HVZEhkqoyKQd9WQUHF6Kzj9lGQB1R1
        +6t8JcfR5MArG0S392L8bEZMc+3VYIMvTxRugU33+7MJXAU9XmZNBTWPQGkpieCGM7zrzmWyyi1y1
        QFP+8KAjxrWcrdXBhjb3Cq1AdjOuc4IsJsYAR762hDGqGjPgUve0LFO12p85AO7uFV/ISZWKnhXuM
        itpaxJGD/QJP8vj1wIbJlnzNdWG3mJqCx9Vf3s5PBaEcWnaIgiEmP8qylqSj60AX4AIFoA26Dxyw+
        Q0wohHrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkVLa-0006Gh-H3; Thu, 06 Apr 2023 19:32:38 +0000
Date:   Thu, 6 Apr 2023 20:32:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dax: enable dax fault handler to report VM_FAULT_HWPOISON
Message-ID: <ZC8eVmF7YdBsDmc4@casper.infradead.org>
References: <20230406175556.452442-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406175556.452442-1-jane.chu@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:55:56AM -0600, Jane Chu wrote:
>  static vm_fault_t dax_fault_return(int error)
>  {
>  	if (error == 0)
>  		return VM_FAULT_NOPAGE;
> -	return vmf_error(error);
> +	else if (error == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	else if (error == -EHWPOISON)
> +		return VM_FAULT_HWPOISON;
> +	return VM_FAULT_SIGBUS;
>  }

Why would we want to handle it here instead of changing vmf_error()?
