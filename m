Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A21194219
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCZOx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 10:53:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59240 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgCZOx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:53:27 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02QErBfW000898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 10:53:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 14444420EBA; Thu, 26 Mar 2020 10:53:11 -0400 (EDT)
Date:   Thu, 26 Mar 2020 10:53:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: Unregister sysfs path before destroying jbd2
 journal
Message-ID: <20200326145311.GR53396@mit.edu>
References: <20200318061301.4320-1-riteshh@linux.ibm.com>
 <20200318091318.GJ22684@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318091318.GJ22684@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:13:18AM +0100, Jan Kara wrote:
> On Wed 18-03-20 11:43:01, Ritesh Harjani wrote:
> > Call ext4_unregister_sysfs(), before destroying jbd2 journal,
> > since below might cause, NULL pointer dereference issue.
> > This got reported with LTP tests.
> > 
> > ext4_put_super() 		cat /sys/fs/ext4/loop2/journal_task
> > 	| 				ext4_attr_show();
> > ext4_jbd2_journal_destroy();  			|
> >     	|				 journal_task_show()
> > 	| 					|
> > 	| 				task_pid_vnr(NULL);
> > sbi->s_journal = NULL;
> > 
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Yeah, makes sence. Thanks for the patch! You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
