Return-Path: <linux-fsdevel+bounces-12018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AF85A48A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5317EB22F60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E636133;
	Mon, 19 Feb 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UXJHEsA4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kva81qCp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UXJHEsA4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kva81qCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8E36124;
	Mon, 19 Feb 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348862; cv=none; b=X90NGmd4HCj6deLBWdGlXH1qM733ip96fJ3pcIVoCZnCt3+aTQGuFObPhqEeSmwvAVrBt6Atqqbp7731kHKBEy8WUq2uhbhmdVCWYP6JZiBo6ytaLUf0eA5mCX9CRgNsrJBp87DmZWeld+mOZ/B8KYQ4Oo/AG2fXpCRKUruJjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348862; c=relaxed/simple;
	bh=PHxysolwHCICHguH06UI9CO3yBfYK+0gqoHhV2sQpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc9D6m2Xp/Gb5aL7nGueruYcbh3dAR1U+chL4RWL54IbsA5XlNcPdEvfKZyGD6kA+PH0Wwrvj2/QgKeOWAKKCu20vNqTckAfxmzfkFNPjgVcCp503zOij+4V2Re+pIhYEs5dQyXsZujp5q4m1+Q7qcpQlA8b2eg2NQsu3ILN1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UXJHEsA4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kva81qCp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UXJHEsA4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Kva81qCp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AD8F1FD14;
	Mon, 19 Feb 2024 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxhXTOS+wh3BB5bUSZa4GxJ5gFzvL6KQIPRFGLV4sIk=;
	b=UXJHEsA4fYqr4+pG0+PzXHuISQOnic/4yiJsENKU8rREcUVfyWl1keP5WEdKBqfVAiyxk+
	1wOg/5zMWXcXtjGacfLe0xlcze26aIuDIxL3xRsQ0uW8DaL5wyjzl1y5gG6LDdsSxBhrEd
	3ROS8w0qrKb2TQsvTvchT21r8UBl/A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxhXTOS+wh3BB5bUSZa4GxJ5gFzvL6KQIPRFGLV4sIk=;
	b=Kva81qCp7jb0cj7grfn+mgRIRTYkkXqnUiaguSBdr3zrocwqkwu6jlfmwi9awGibikrsiL
	sCv9G/ySqlcWPBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxhXTOS+wh3BB5bUSZa4GxJ5gFzvL6KQIPRFGLV4sIk=;
	b=UXJHEsA4fYqr4+pG0+PzXHuISQOnic/4yiJsENKU8rREcUVfyWl1keP5WEdKBqfVAiyxk+
	1wOg/5zMWXcXtjGacfLe0xlcze26aIuDIxL3xRsQ0uW8DaL5wyjzl1y5gG6LDdsSxBhrEd
	3ROS8w0qrKb2TQsvTvchT21r8UBl/A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxhXTOS+wh3BB5bUSZa4GxJ5gFzvL6KQIPRFGLV4sIk=;
	b=Kva81qCp7jb0cj7grfn+mgRIRTYkkXqnUiaguSBdr3zrocwqkwu6jlfmwi9awGibikrsiL
	sCv9G/ySqlcWPBBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5D313585;
	Mon, 19 Feb 2024 13:20:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PtGyD7dV02U6BAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Mon, 19 Feb 2024 13:20:55 +0000
Date: Tue, 20 Feb 2024 00:20:15 +1100
From: David Disseldorp <ddiss@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
 linux-fsdevel@vger.kernel.org, kdevops@lists.linux.dev,
 patches@lists.linux.dev
Subject: Re: [PATCH v3 fstests] check: add support for --start-after
Message-ID: <20240220002015.52ba31bc@echidna>
In-Reply-To: <20240216180946.784869-1-mcgrof@kernel.org>
References: <20240216180946.784869-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UXJHEsA4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Kva81qCp
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6AD8F1FD14
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Fri, 16 Feb 2024 10:09:46 -0800, Luis Chamberlain wrote:

...
>  check | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/check b/check
> index 71b9fbd07522..f081bf8ce685 100755
> --- a/check
> +++ b/check
> @@ -18,6 +18,7 @@ showme=false
>  have_test_arg=false
>  randomize=false
>  exact_order=false
> +start_after_test=""
>  export here=`pwd`
>  xfile=""
>  subdir_xfile=""
> @@ -80,6 +81,7 @@ check options
>      -b			brief test summary
>      -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
>      --large-fs		optimise scratch device for large filesystems
> +    --start-after	only start testing after the test specified

The usage text should include the <test> parameter.

>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
>      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> @@ -120,6 +122,8 @@ examples:
>   check -x stress xfs/*
>   check -X .exclude -g auto
>   check -E ~/.xfstests.exclude
> + check --start-after btrfs/010
> + check -n -g soak --start-after generic/522
>  '
>  	    exit 1
>  }
> @@ -204,6 +208,23 @@ trim_test_list()
>  	rm -f $tmp.grep
>  }
>  
> +# takes the list of tests to run in $tmp.list and skips all tests until
> +# the specified test is found. This will ensure the tests start after the
> +# test specified, it skips the test specified.
> +trim_start_after()
> +{
> +	local skip_test="$1"
> +	local starts_regexp=$(echo $skip_test | sed -e 's|\/|\\/|')
> +
> +	if grep -q $skip_test $tmp.list ; then
> +		rm -f $tmp.grep
> +		awk 'f;/.*'$starts_regexp'/{f=1}' $tmp.list > $tmp.tmp
> +		mv $tmp.tmp $tmp.list
> +	else
> +		echo "Test $skip_test not found in test list, be sure to use a valid test if using --start-after"
> +		exit 1
> +	fi
> +}

nit: it should be possible to collapse the sed+grep+awk into something a
bit more straightforward, e.g.

trim_start_after()
{
        if awk -v skip_test="tests/$1" \
           'f; $0 == skip_test {f=1} END {exit f}' $tmp.list > $tmp.tmp; then
                echo "$1 not found in test list, be sure to use a valid test if using --start-after"
                rm $tmp.tmp
                exit 1
        fi
        mv $tmp.tmp $tmp.list
}

>  
>  _wallclock()
>  {
> @@ -233,6 +254,9 @@ _prepare_test_list()
>  		# no test numbers, do everything
>  		get_all_tests
>  	else
> +		local group_all
> +		local start_after_found=0
> +		list=""
>  		for group in $GROUP_LIST; do
>  			list=$(get_group_list $group)
>  			if [ -z "$list" ]; then
> @@ -240,11 +264,28 @@ _prepare_test_list()
>  				exit 1
>  			fi
>  
> +			if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
> +				echo $list | grep -q $start_after_test
> +				if [[ $? -eq 0 ]]; then
> +					start_after_found=1
> +				fi
> +			fi
>  			for t in $list; do
>  				grep -s "^$t\$" $tmp.list >/dev/null || \
>  							echo "$t" >>$tmp.list
>  			done
> +			group_all="$group_all $list"
>  		done
> +		if [[ "$start_after_test" != "" && $start_after_found -ne 1 ]]; then
> +			group_all=$(echo $group_all | sed -e 's|tests/||g')
> +			echo "Start after test $start_after_test not found in any group specified."
> +			echo "Be sure you specify a test present in one of your test run groups if using --start-after."
> +			echo
> +			echo "Your set of groups have these tests:"
> +			echo
> +			echo $group_all
> +			exit 1
> +		fi
>  	fi

Can't all of the _prepare_test_list() changes above be dropped?
trim_start_after() already performs the check that the test exists, and
with the above dropped we could also do things like, e.g.
  ./check --start-after generic/002 generic/00[1-9]

>  	# Specified groups to exclude
> @@ -258,6 +299,10 @@ _prepare_test_list()
>  		trim_test_list $list
>  	done
>  
> +	if [[ "$start_after_test" != "" ]]; then
> +		trim_start_after $start_after_test
> +	fi
> +
>  	# sort the list of tests into numeric order unless we're running tests
>  	# in the exact order specified
>  	if ! $exact_order; then
> @@ -313,6 +358,14 @@ while [ $# -gt 0 ]; do
>  				<(sed "s/#.*$//" $xfile)
>  		fi
>  		;;
> +	--start-after)
> +		if $randomize; then
> +			echo "Cannot specify -r and --start-after."
> +			exit 1
> +		fi

IIUC, this will only trigger if -r is parsed before --start-after, so it
should be moved after the loop.

> +		start_after_test="$2"
> +		shift
> +		;;
>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
>  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
>  	-l)	diff="diff" ;;


